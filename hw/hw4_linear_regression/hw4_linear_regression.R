# HW 4 - Linear Regression w/ Boston Housing Data
# Camron Khan

#==================================================================================================

# IMPORTS

#install.packages("caret")
#install.packages("AppliedPredictiveModeling")

library(caret)
library(AppliedPredictiveModeling)

DATA <- read.csv('./Boston.csv', stringsAsFactors = FALSE)

#==================================================================================================

# DEFINITIONS

# X         int     index
# crim:     real    per capita crime rate by town
# zn:       real    proportion of residential land zoned for lots over 25,000 sq.ft
# indus:    real    proportion of non-retail business acres per town
# chas:     int     Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
# nox:      real    nitrogen oxides concentration (parts per 10 million)
# rm:       real    average number of rooms per dwelling
# age:      real    proportion of owner-occupied units built prior to 1940
# dis:      real    weighted mean of distances to five Boston employment centers
# rad:      int     index of accessibility to radial highways
# tax:      int     full-value property-tax rate per \$10,000
# ptratio:  real    pupil-teacher ratio by town
# black:    real    1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
# lstat:    real    lower status of the population (percent)
# medv:     real    median value of owner-occupied homes in \$1000s     DEPENDENT VARIABLE

#==================================================================================================

# EDA

str(DATA)

transparentTheme(trans = .4)
featurePlot(x = DATA[,2:14], y = DATA$medv)
cor(DATA[,2:15])

#==================================================================================================



























