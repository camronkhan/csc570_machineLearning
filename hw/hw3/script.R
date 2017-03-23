# HW 3 - Naive Bayes Classification
# Camron Khan

#========================================================================================================

# IMPORTS

#install.packages("tm")
#install.packages("SnowballC")

library(tm)
library(SnowballC)

train_ham_dir = "../../../data/ml_hw3/hw3_train/train/ham/"
train_spam_dir = "../../../data/ml_hw3/hw3_train/train/spam/"
test_ham_dir = "../../../data/ml_hw3/hw3_test/test/ham/"
test_spam_dir = "../../../data/ml_hw3/hw3_test/test/spam/"

train_ham_corpus = VCorpus(DirSource(directory = train_ham_dir, encoding = "UTF-8"))
train_spam_corpus = VCorpus(DirSource(directory = train_spam_dir, encoding = "UTF-8"))
test_ham_corpus = VCorpus(DirSource(directory = test_ham_dir, encoding = "UTF-8"))
test_spam_corpus = VCorpus(DirSource(directory = test_spam_dir, encoding = "UTF-8"))

#========================================================================================================

# EDA

inspect(train_ham_corpus)
as.character((train_ham_corpus[[5]]))

inspect(train_spam_corpus)
as.character((train_spam_corpus[[5]]))

inspect(test_ham_corpus)
as.character((test_ham_corpus[[5]]))

inspect(test_spam_corpus)
as.character((test_spam_corpus[[5]]))

#========================================================================================================

# CLEAN AND PARSE TEXT

train_ham_dtm <- DocumentTermMatrix(train_ham_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, stopwords = TRUE, removePunctuation = TRUE, stemming = TRUE))
train_spam_dtm <- DocumentTermMatrix(train_spam_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, stopwords = TRUE, removePunctuation = TRUE, stemming = TRUE))
test_ham_dtm <- DocumentTermMatrix(test_ham_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, stopwords = TRUE, removePunctuation = TRUE, stemming = TRUE))
test_spam_dtm <- DocumentTermMatrix(test_spam_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, stopwords = TRUE, removePunctuation = TRUE, stemming = TRUE))

#========================================================================================================















