# kaggleps

Currently at

[1] "Tuning params"
   nrounds max_depth  eta gamma colsample_bytree min_child_weight subsample
57     650         5 0.02     1                1                1         1
Best CV Gini  : 0.2807336
    eta max_depth gamma colsample_bytree min_child_weight subsample nrounds       ROC      Sens         Spec
57 0.02         5     1                1                1         1     650 0.6403668 0.9999826 0.0003687592
        Gini       ROCSD       SensSD       SpecSD      GiniSD
57 0.2807336 0.004762742 1.067748e-05 0.0001262179 0.009525484

> names(trainset)
 [1] "ps_ind_01"            "ps_ind_02_cat"        "ps_ind_03"            "ps_ind_04_cat"       
 [5] "ps_ind_05_cat"        "ps_ind_06_bin"        "ps_ind_07_bin"        "ps_ind_08_bin"       
 [9] "ps_ind_09_bin"        "ps_ind_10_bin"        "ps_ind_11_bin"        "ps_ind_12_bin"       
[13] "ps_ind_13_bin"        "ps_ind_14"            "ps_ind_15"            "ps_ind_16_bin"       
[17] "ps_ind_17_bin"        "ps_ind_18_bin"        "ps_reg_01"            "ps_reg_02"           
[21] "ps_reg_03"            "ps_car_01_cat"        "ps_car_02_cat"        "ps_car_03_cat"       
[25] "ps_car_04_cat"        "ps_car_05_cat"        "ps_car_06_cat"        "ps_car_07_cat"       
[29] "ps_car_08_cat"        "ps_car_09_cat"        "ps_car_10_cat"        "ps_car_11_cat"       
[33] "ps_car_11"            "ps_car_12"            "ps_car_13"            "ps_car_14"           
[37] "ps_car_15"            "ps_calc_01"           "ps_calc_02"           "ps_calc_03"          
[41] "ps_calc_04"           "ps_calc_05"           "ps_calc_06"           "ps_calc_07"          
[45] "ps_calc_08"           "ps_calc_09"           "ps_calc_10"           "ps_calc_11"          
[49] "ps_calc_12"           "ps_calc_13"           "ps_calc_14"           "ps_calc_15_bin"      
[53] "ps_calc_16_bin"       "ps_calc_17_bin"       "ps_calc_18_bin"       "ps_calc_19_bin"      
[57] "ps_calc_20_bin"       "ps_car.13_ps_reg_03"  "ps_reg.mult"          "count.missing"       
[61] "count.sum.ps_ind"     "count.sum.ps_calc"    "count.missing.ps_car" "count.missing.ps_reg"
[65] "count.missing.ps_ind"

Tuning suggests smaller tree depth is better
nr of iterations & eta sort of inverse related as always

submitted; LB score only .277/.278 instead of CV of .282 here

    eta max_depth gamma colsample_bytree min_child_weight subsample nrounds       ROC      Sens         Spec      Gini
95 0.05         4     1                1                1         1     300 0.6414324 0.9999808 0.0004148421 0.2828647
         ROCSD       SensSD       SpecSD      GiniSD
95 0.002185704 3.898815e-06 0.0003786973 0.004371408



Tuning parameter 'gamma' was held constant at a value of 1
Tuning parameter 'colsample_bytree' was
 held constant at a value of 1
Tuning parameter 'min_child_weight' was held constant at a value of
 1
Tuning parameter 'subsample' was held constant at a value of 1
Gini was used to select the optimal model using  the largest value.
The final values used for the model were nrounds = 800, max_depth = 4, eta = 0.02, gamma =
 1, colsample_bytree = 1, min_child_weight = 1 and subsample = 1.
Warning: Ignoring unknown aesthetics: shape
[1] "Tuning params"
   nrounds max_depth  eta gamma colsample_bytree min_child_weight subsample
60     800         4 0.02     1                1                1         1
Best CV Gini  : 0.2837303
    eta max_depth gamma colsample_bytree min_child_weight subsample nrounds       ROC      Sens
60 0.02         4     1                1                1         1     800 0.6418651 0.9999808
          Spec      Gini       ROCSD       SensSD       SpecSD    GiniSD
60 0.000460957 0.2837303 0.006169199 1.526703e-05 0.0004345243 0.0123384
[1] "data/submission_2017-10-14_07-42-16.csv"
     user    system   elapsed 
402982.74   1149.87  60342.56 


Tuning parameter 'gamma' was held constant at a value of 1
Tuning parameter 'colsample_bytree' was
 held constant at a value of 1
Tuning parameter 'min_child_weight' was held constant at a value of
 1
Tuning parameter 'subsample' was held constant at a value of 1
Gini was used to select the optimal model using  the largest value.
The final values used for the model were nrounds = 550, max_depth = 4, eta = 0.03, gamma =
 1, colsample_bytree = 1, min_child_weight = 1 and subsample = 1.
Warning: Ignoring unknown aesthetics: shape
[1] "Tuning params"
    nrounds max_depth  eta gamma colsample_bytree min_child_weight subsample
100     550         4 0.03     1                1                1         1
Best CV Gini  : 0.2830481
     eta max_depth gamma colsample_bytree min_child_weight subsample nrounds       ROC      Sens
100 0.03         4     1                1                1         1     550 0.6415241 0.9999756
            Spec      Gini       ROCSD      SensSD       SpecSD     GiniSD
100 0.0003687698 0.2830481 0.006580445 2.35373e-05 0.0002915662 0.01316089
[1] "data/submission_2017-10-17_10-24-48.csv"
     user    system   elapsed 
440830.16   1218.11  65351.58 

still only at 0.278...

