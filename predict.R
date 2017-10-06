# Kaggle Porto Seguro competition 2017

library(tidyverse)  
library(data.table)
library(stringr)
library(lubridate)
library(dplyr)
library(caret)
library(ggplot2)
library(ggthemes)
# library(DBI)
# library(clipr)
theme_set(theme_minimal())

# source("utils.R")

data <- fread("data/train.csv")
print(dim(data))
print(summary(data))

# Preps for modeling

print("Modeling")

target <- factor(make.names(data$target))
trainset <- data[, -c("target","id"), with=F]

# consider trick to join trainset&test together so all done smae way

# Make numeric
symCols <- names(trainset)[!sapply(trainset, is.numeric)]
for (symcol in symCols) {
  levels <- unique(trainset[[symcol]])
  trainset[[symcol]] <- as.integer(factor(trainset[[symcol]],levels=levels))
}

# Simple NA imputation
for (col in names(trainset)) {
  # cat(col, sum(!complete.cases(trainset[[col]])), fill=T)
  trainset[[col]] <- ifelse(is.na(trainset[[col]]), -1234567, trainset[[col]])
}

# other ideas
# are we reading "" as NA?
# row sum of all the _bin vars per categorey, e.g. ps_ind_xx_bin, ps_calc_xx_bin etc
#data[, amount_nas := rowSums(data == -1, na.rm = T)]
#data[, high_nas := ifelse(amount_nas>4,1,0)

#???
trainset[, ps_car.13_ps_reg_03 := ps_car_13*ps_reg_03] # WTF?
trainset[, ps_reg.mult := ps_reg_01*ps_reg_02*ps_reg_03] # WTF?

trainset[, count.missing := rowSums(.SD == -1, na.rm = T)]
trainset[, count.sum.ps_ind := rowSums(.SD == 1), 
         .SDcols = which( grepl("^ps_ind_[[:digit:]]+_bin$",names(trainset)) )]
trainset[, count.sum.ps_calc := rowSums(.SD == 1), 
         .SDcols = which( grepl("^ps_calc_[[:digit:]]+_bin$",names(trainset)) )]
# missing by type
trainset[, count.missing.ps_car := rowSums(.SD == -1), 
         .SDcols = which( grepl("^ps_car_.*$",names(trainset)) )]
trainset[, count.missing.ps_reg := rowSums(.SD == -1), 
         .SDcols = which( grepl("^ps_reg_.*$",names(trainset)) )]
trainset[, count.missing.ps_ind := rowSums(.SD == -1), 
         .SDcols = which( grepl("^ps_ind_.*$",names(trainset)) )]

# Univariate var importance
allAUC <- filterVarImp(x = trainset, y = target)
varImp <- data.frame(field = rownames(allAUC), 
                     AUC = allAUC[,1], 
                     isDerived = !rownames(allAUC) %in% names(data),
                     type=sapply(rownames(allAUC), function(x) { return (class(trainset[[x]])[1]) })) %>%
  arrange(AUC)
p <- ggplot(tail(varImp,50), 
            aes(x=factor(field,levels=field), y=AUC, label=sprintf("%.2f",AUC), fill=type, alpha=I(ifelse(isDerived, 0.4, 1))))+
  geom_bar(stat="identity")+
  geom_text(size=2,color="black",alpha=1)+
  coord_flip()+
  ggtitle("Univariate Performance")+
  xlab("Feature")+ylab("AUC")+
  scale_y_continuous(labels = scales::percent)+
  geom_hline(yintercept=0.50,linetype="dashed")
print(p)

# Build model

gini <- function(data, lev=NULL, model=NULL){
  twoClassSumm <- twoClassSummary(data, lev, model)
  # print(twoClassSumm)
  out <- c(twoClassSumm, twoClassSumm[1]*2-1)
  names(out) <- c(names(twoClassSumm), "Gini")
  out
}

crossValidation <- trainControl(
  # method = "none", # Fitting models without parameter tuning
  method = "cv", # "repeatedcv" and repeats
  number=5,
  summaryFunction = gini,
  classProbs = TRUE,
  # verbose=T,
  verboseIter=T,
  allowParallel=T)

# ideas on XGB hyp params see https://i.stack.imgur.com/9GgQK.jpg

xgbGrid <- expand.grid(nrounds = seq(100,800,by=50)
                       ,eta = c(0.01,0.02,0.05)
                       ,max_depth = c(5,7,9)
                       ,gamma = 1
                       ,colsample_bytree = 1
                       ,min_child_weight = 1
                       ,subsample = 1) 

model <- train(x = trainset, 
               y = target,
               method = "xgbTree"
               ,tuneGrid = xgbGrid
               # ,metric = "Error"
               # ,maximize=F
               ,metric = "Gini" 
               ,maximize=T
               ,trControl = crossValidation
               ,verbose=T)

# Report on model
# print(ggplot(varImp(model)))
print(head(varImp(model)$importance,20))
# xgb.ggplot.importance below does a better job
# print(ggplot(varImp(model)$importance %>% mutate(field=rownames(varImp(model)$importance)) %>% dplyr::rename(Importance = Overall) %>% 
#          arrange(Importance) %>% filter(Importance > 0.1),
#        aes(x=factor(field, levels=field), y=Importance)) +
#   geom_bar(stat="identity")+
#   theme(axis.title.y=element_blank())+
#   coord_flip())

# Report on CV tuning
print(model)
print(ggplot(model) + ggtitle("Tuning"))
# cat("Best CV error:",min(model$results$Error),fill=T)
# cat("AUC for lowest error:",model$results$ROC[which.min(model$results$Error)],fill=T)

print("Tuning params")
print(model$finalModel$tuneValue)

# XGB display - model$finalModel
# print(xgb.ggplot.deepness(model = model$finalModel, which="2x1") [[1]][[2]])
# xgb.plot.multi.trees(feature_names = names(trainset), model=model$finalModel, features_keep=3)
xgbImportance <- xgb.importance(names(trainset), model=model$finalModel)
print(xgb.ggplot.importance(head(xgbImportance,40))+ ggtitle("Model Var Importance"))

cat("Best CV Gini  :",max(model$results$Gini),fill=T)
print (model$results[which.max(model$results$Gini),])


# preds <- predict(model, newdata = x_test, type = "prob")
