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

# EDA

# Summarize data
str(DATA)
summary(DATA)

transparentTheme(trans = .4)
featurePlot(x = DATA[,2:14], y = DATA$medv, plot = "pairs")

#==================================================================================================



























