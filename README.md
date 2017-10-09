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

TODO prep for scoring
