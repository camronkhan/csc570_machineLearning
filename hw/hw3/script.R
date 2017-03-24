# HW 3 - Naive Bayes Classification
# Camron Khan

#===========================================================================================================================================

# IMPORTS

#install.packages("tm")
#install.packages("SnowballC")
#install.packages("wordcloud")
#install.packages("RColorBrewer")
#install.packages("e1071")

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(e1071)

train_ham_dir <- "./data.gi/train/ham/"
train_spam_dir <- "./data.gi/train/spam/"
test_ham_dir <- "./data.gi/test/ham/"
test_spam_dir <- "./data.gi/test/spam/"

train_ham_corpus <- SimpleCorpus(DirSource(directory = train_ham_dir, encoding = "UTF-8"))
train_spam_corpus <- SimpleCorpus(DirSource(directory = train_spam_dir, encoding = "UTF-8"))
test_ham_corpus <- SimpleCorpus(DirSource(directory = test_ham_dir, encoding = "UTF-8"))
test_spam_corpus <- SimpleCorpus(DirSource(directory = test_spam_dir, encoding = "UTF-8"))

#===========================================================================================================================================

# CLEAN TEXT AND PARSE TO DTM

customStopWords <- c(stopwords("english"), "to", "cc", "bcc", "subject", "re", "from", "can", "will")
train_ham_dtm <- DocumentTermMatrix(train_ham_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, removePunctuation = TRUE, stopwords = customStopWords, stemming = TRUE))
train_spam_dtm <- DocumentTermMatrix(train_spam_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, removePunctuation = TRUE, stopwords = customStopWords, stemming = TRUE))
test_ham_dtm <- DocumentTermMatrix(test_ham_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, removePunctuation = TRUE, stopwords = customStopWords, stemming = TRUE))
test_spam_dtm <- DocumentTermMatrix(test_spam_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, removePunctuation = TRUE, stopwords = customStopWords, stemming = TRUE))

#===========================================================================================================================================

# GET HAM / SPAM LABELS

train_ham_labels <- lapply(vector(mode = "character", length = train_ham_dtm$nrow), function(x) { "ham" })
train_spam_labels <- lapply(vector(mode = "character", length = train_spam_dtm$nrow), function(x) { "spam" })
test_ham_labels <- lapply(vector(mode = "character", length = test_ham_dtm$nrow), function(x) { "ham" })
test_spam_labels <- lapply(vector(mode = "character", length = test_spam_dtm$nrow), function(x) { "spam" })

#===========================================================================================================================================

# CONVERT DTM TO DOCUMENT TERM DATAFRAME WITH LABELS

train_ham_matrix <- as.matrix(train_ham_dtm)
train_ham_dtdf <- as.data.frame(train_ham_matrix)
train_ham_dtdf$OUTCOME <- train_ham_labels

train_spam_matrix <- as.matrix(train_spam_dtm)
train_spam_dtdf <- as.data.frame(train_spam_matrix)
train_spam_dtdf$OUTCOME <- train_spam_labels

test_ham_matrix <- as.matrix(test_ham_dtm)
test_ham_dtdf <- as.data.frame(test_ham_matrix)
test_ham_dtdf$OUTCOME <- test_ham_labels

test_spam_matrix <- as.matrix(test_spam_dtm)
test_spam_dtdf <- as.data.frame(test_spam_matrix)
test_spam_dtdf$OUTCOME <- test_spam_labels

#===========================================================================================================================================

# WORD CLOUDS

colorPalette <- brewer.pal(8, "Dark2")

train_ham_matrix <- as.matrix(train_ham_dtm)

train_ham_dtdf <- as.data.frame(train_ham_matrix)

train_ham_freqs <- sort(colSums(train_ham_matrix), decreasing = TRUE)
train_ham_words <- names(train_ham_freqs)
train_ham_df <- data.frame(word = train_ham_words, freq = train_ham_freqs)
png("train_ham_wc.png", width=1280,height=800)
wordcloud(words = train_ham_df$word, freq = train_ham_df$freq, max.words = 50, min.freq = 2, rot.per = 0.15, scale = c(3, 0.5), random.order = FALSE, colors = colorPalette)
dev.off()

train_spam_matrix <- as.matrix(train_spam_dtm)
train_spam_freqs <- sort(colSums(train_spam_matrix), decreasing = TRUE)
train_spam_words <- names(train_spam_freqs)
train_spam_df <- data.frame(word = train_spam_words, freq = train_spam_freqs)
png("train_spam_wc.png", width=1280,height=800)
wordcloud(words = train_spam_df$word, freq = train_spam_df$freq, max.words = 50, min.freq = 2, rot.per = 0.15, scale = c(3, 0.5), random.order = FALSE, colors = colorPalette)
dev.off()



