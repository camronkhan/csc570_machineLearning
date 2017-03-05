# CSC 570 - Machine Learning
# HW 2 - k Nearest Neighbors
# Camron Khan


# 0. Clear environment and load dependencies.
rm(list=ls())
install.packages("caret")
install.packages("gmodels")
install.packages("MLmetrics")
library(caret)
library(class)
library(gmodels)
library(MLmetrics)


# 1. Download the dataset Auto.csv.
data = read.csv("../../src/csc570_machineLearning/hw/hw2/Auto.csv", stringsAsFactors = FALSE)


# 2. Explore the overall structure of the datasetusing str(). Describe it one paragraph.
str(data)


# 3. Convert the attribute horsepower from character to integer.
data$horsepower <- as.integer(data$horsepower)


# 4. The horsepower attribute has some missing values. Remove the observations with missing values, i.e., delete the rows with missing values from the data frame.
data <- data[!is.na(data$horsepower),]


# 5. Explore the data in order to investigate the association between mpg and the other features. Which of the other features seem most likely to be useful in predicting mpg (scatterplots may be useful tools to answer this question). Describe your findings.
plot(data$cylinders, data$mpg, main = "mpg vs cylinders", xlab = "cylinders", ylab = "mpg")
plot(data$displacement, data$mpg, main = "mpg vs displacement", xlab = "displacement", ylab = "mpg")
plot(data$horsepower, data$mpg, main = "mpg vs horsepower", xlab = "horsepower", ylab = "mpg")
plot(data$weight, data$mpg, main = "mpg vs weight", xlab = "weight", ylab = "mpg")
plot(data$acceleration, data$mpg, main = "mpg vs acceleration", xlab = "acceleration", ylab = "mpg")
plot(data$year, data$mpg, main = "mpg vs year", xlab = "year", ylab = "mpg")
plot(data$origin, data$mpg, main = "mpg vs origin", xlab = "origin", ylab = "mpg")


# 6. Create a new attribute mpg1 that contains 1 if mpg is strictly greater than its median, and 0 if mpg is equal or less than its median. 
data$mpg1 <- sapply(data$mpg, function(x) { if(x > median(data$mpg)) 1 else 0 })

# Create a new attribute make that stores the car's manufacturer. Fix spelling errors. Store as factor.
data$make <- gsub("([A-Za-z]+).*", "\\1", data$name)
fixSpelling <- function(x) {
  if (x == "toyouta") { return ("toyota") }
  if (x == "maxda") { return ("mazda") }
  if (x == "chevroelt") { return ("chevrolet") }
  return (x)
}
data$make <- as.factor(sapply(data$make, fixSpelling))


# 7. Decide which attributes you are going to use to predict mpg1. Remove all remaining attributes, including mpg.
data_with_categorical <- subset(data, select = c("mpg1", "weight", "displacement", "cylinders", "horsepower", "acceleration", "year", "make", "origin"))
data_only_numeric <- subset(data, select = c("mpg1", "weight", "displacement", "cylinders", "horsepower", "acceleration", "year"))

# Dummy out categorical variables.
data_with_categorical$origin <- as.factor(data_with_categorical$origin)
data_dummy <- dummyVars(" ~ .", data = data_with_categorical)
data_with_categorical <- data.frame(predict(data_dummy, newdata = data_with_categorical))


# 8. Set the seed of the random number generator to a fixed integer, say 1, so that you can reproduce your work.
set.seed(1)


# 9. Normalize the attribute values.
normalize <- function(x) { return ((x - min(x)) / (max(x) - min(x))) }
data_with_categorical_normal <- as.data.frame(lapply(data_with_categorical, normalize))
data_only_numeric_normal<- as.data.frame(lapply(data_only_numeric, normalize))


# 10. Randomize the order of the rows in the dataset.
data_with_categorical_random <- data_with_categorical_normal[sample(nrow(data_with_categorical_normal)), ]
data_only_numeric_random <- data_only_numeric_normal[sample(nrow(data_only_numeric_normal)), ]


# 11. Split the data into a training set and a test set. Use a test set of 100 rows.

# With categorical
data_with_categorical_train <- data_with_categorical_random[1:(nrow(data_with_categorical_random)-100), ]
data_with_categorical_test <- data_with_categorical_random[(nrow(data_with_categorical_random)-99):nrow(data_with_categorical_random), ]
X_with_categorical_train <- data_with_categorical_train[,2:ncol(data_with_categorical_train)]
y_with_categorical_train <- data_with_categorical_train[,1]
X_with_categorical_test <- data_with_categorical_test[,2:ncol(data_with_categorical_test)]
y_with_categorical_test <- data_with_categorical_test[,1]

# Only numeric
data_only_numeric_train <- data_only_numeric_random[1:(nrow(data_only_numeric_random)-100), ]
data_only_numeric_test <- data_only_numeric_random[(nrow(data_only_numeric_random)-99):nrow(data_only_numeric_random), ]
X_only_numeric_train <- data_only_numeric_train[,2:ncol(data_only_numeric_train)]
y_only_numeric_train <- data_only_numeric_train[,1]
X_only_numeric_test <- data_only_numeric_test[,2:ncol(data_only_numeric_test)]
y_only_numeric_test <- data_only_numeric_test[,1]


# 12. Perform kNN on the training data, with several values of K, in order to predict mpg1. What test errors do you obtain? Which value of K seems to perform the best on this dataset?
k_vals <- c(1, 5, 10, 15, 25, 30, 40, 60, 100)

# With categorical
evaluate_with_categorical_performance <- function(x) {
  y_with_categorical_pred <- knn(train = X_with_categorical_train, test = X_with_categorical_test, cl = y_with_categorical_train, k = x)
  y_with_categorical_CM <- confusionMatrix(data = y_with_categorical_pred, reference = y_with_categorical_test, mode = "prec_recall")
  y_with_categorical_accuracy <- y_with_categorical_CM$overall[['Accuracy']]
  y_with_categorical_recall <- y_with_categorical_CM$byClass[['Recall']]
  y_with_categorical_precision <- y_with_categorical_CM$byClass[['Precision']]
  y_with_categorical_false_negatives <- as.integer(y_with_categorical_CM$table[3])
  y_with_categorical_false_positives <- as.integer(y_with_categorical_CM$table[2])
  y_with_categorical_total_errors <- as.integer(y_with_categorical_false_negatives + y_with_categorical_false_positives)
  return (c(as.integer(x), y_with_categorical_accuracy, y_with_categorical_recall, y_with_categorical_precision, y_with_categorical_false_negatives, y_with_categorical_false_positives, y_with_categorical_total_errors))
}
knn_with_categorical_performance <- sapply(k_vals, evaluate_with_categorical_performance)
df_knn_with_categorical_performance <- as.data.frame(t(knn_with_categorical_performance))
colnames(df_knn_with_categorical_performance) <- c("k", "Accuracy", "Recall", "Precision", "False Neg", "False Pos", "Tot Errors")
attr(df_knn_with_categorical_performance, "title") <- "Performance of kNN on Dataset Including Categorical Attributes (Make, Origin)"
df_knn_with_categorical_performance

# Only numeric
evaluate_only_numeric_performance <- function(x) {
  y_only_numeric_pred <- knn(train = X_only_numeric_train, test = X_only_numeric_test, cl = y_only_numeric_train, k = x)
  y_only_numeric_CM <- confusionMatrix(data = y_only_numeric_pred, reference = y_only_numeric_test, mode = "prec_recall")
  y_only_numeric_accuracy <- y_only_numeric_CM$overall[['Accuracy']]
  y_only_numeric_recall <- y_only_numeric_CM$byClass[['Recall']]
  y_only_numeric_precision <- y_only_numeric_CM$byClass[['Precision']]
  y_only_numeric_false_negatives <- as.integer(y_only_numeric_CM$table[3])
  y_only_numeric_false_positives <- as.integer(y_only_numeric_CM$table[2])
  y_only_numeric_total_errors <- as.integer(y_only_numeric_false_negatives + y_only_numeric_false_positives)
  return (c(as.integer(x), y_only_numeric_accuracy, y_only_numeric_recall, y_only_numeric_precision, y_only_numeric_false_negatives, y_only_numeric_false_positives, y_only_numeric_total_errors))
}
knn_only_numeric_performance <- sapply(k_vals, evaluate_only_numeric_performance)
df_knn_only_numeric_performance <- as.data.frame(t(knn_only_numeric_performance))
colnames(df_knn_only_numeric_performance) <- c("k", "Accuracy", "Recall", "Precision", "False Neg", "False Pos", "Tot Errors")
attr(df_knn_only_numeric_performance, "title") <- "Performance of kNN on Dataset Excluding Categorical Attributes"
df_knn_only_numeric_performance

# Display Cross Table / Confusion Matrix for best performance
y_pred_best <- knn(train = X_only_numeric_train, test = X_only_numeric_test, cl = y_only_numeric_train, k = 5)
CrossTable(x = y_only_numeric_test, y = y_pred_best, prop.chisq = FALSE)
confusionMatrix(data = y_pred_best, reference = y_only_numeric_test, mode = "prec_recall")

# 13. Save the session into script.txt using savehistory("script.txt")
savehistory("script.txt")
