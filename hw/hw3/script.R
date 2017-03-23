# HW 3 - Naive Bayes Classification
# Camron Khan

#===========================================================================================================================================

# IMPORTS

#install.packages("tm")
#install.packages("SnowballC")
#install.packages("wordcloud")
#install.packages("RColorBrewer")

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

train_ham_dir = "../../../data/ml_hw3/hw3_train/train/ham/"
train_spam_dir = "../../../data/ml_hw3/hw3_train/train/spam/"
test_ham_dir = "../../../data/ml_hw3/hw3_test/test/ham/"
test_spam_dir = "../../../data/ml_hw3/hw3_test/test/spam/"

train_ham_corpus = VCorpus(DirSource(directory = train_ham_dir, encoding = "UTF-8"))
train_spam_corpus = VCorpus(DirSource(directory = train_spam_dir, encoding = "UTF-8"))
test_ham_corpus = VCorpus(DirSource(directory = test_ham_dir, encoding = "UTF-8"))
test_spam_corpus = VCorpus(DirSource(directory = test_spam_dir, encoding = "UTF-8"))

#===========================================================================================================================================

# EDA

inspect(train_ham_corpus)
as.character((train_ham_corpus[[5]]))

inspect(train_spam_corpus)
as.character((train_spam_corpus[[5]]))

#===========================================================================================================================================

# CLEAN AND PARSE TEXT

customStopWords <- c(stopwords("english"), "to", "cc", "bcc", "subject", "re", "from", "can", "will")
train_ham_dtm <- DocumentTermMatrix(train_ham_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, removePunctuation = TRUE, stopwords = customStopWords, stemming = TRUE))
train_spam_dtm <- DocumentTermMatrix(train_spam_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, removePunctuation = TRUE, stopwords = customStopWords, stemming = TRUE))
test_ham_dtm <- DocumentTermMatrix(test_ham_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, removePunctuation = TRUE, stopwords = customStopWords, stemming = TRUE))
test_spam_dtm <- DocumentTermMatrix(test_spam_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, removePunctuation = TRUE, stopwords = customStopWords, stemming = TRUE))

#===========================================================================================================================================

# WORD CLOUDS

colorPalette <- brewer.pal(8, "Dark2")

train_ham_matrix <- as.matrix(train_ham_dtm)
train_ham_freqs <- sort(colSums(train_ham_matrix), decreasing = TRUE)
train_ham_words <- names(train_ham_freqs)
train_ham_df <- data.frame(word = train_ham_words, freq = train_ham_freqs)
train_ham_wc <- wordcloud(words = train_ham_df$word, freq = train_ham_df$freq, max.words = 50, min.freq = 2, rot.per = 0.15, scale = c(3, 0.5), random.order = FALSE, colors = colorPalette)

train_spam_matrix <- as.matrix(train_spam_dtm)
train_spam_freqs <- sort(colSums(train_spam_matrix), decreasing = TRUE)
train_spam_words <- names(train_spam_freqs)
train_spam_df <- data.frame(word = train_spam_words, freq = train_spam_freqs)
train_spam_wc <- wordcloud(words = train_spam_df$word, freq = train_spam_df$freq, max.words = 50, min.freq = 2, rot.per = 0.15, scale = c(3, 0.5), random.order = FALSE, colors = colorPalette)




