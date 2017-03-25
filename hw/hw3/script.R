# HW 3 - Naive Bayes Classification
# Camron Khan

#===========================================================================================================================================

# IMPORTS

#install.packages("tm")
#install.packages("SnowballC")
#install.packages("wordcloud")
#install.packages("e1071")

library(tm)
library(SnowballC)
library(wordcloud)
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

# PARSE CORPUS TO DF AND COMBINE SPAM AND HAM

parseCorpusToDataFrame <- function(corpus, type) {
  name <- as.vector(names(corpus))
  text <- unlist(corpus, use.names = FALSE)
  text <- as.vector(text[1:length(text)-1])
  type <- sapply(name, function(x) type)
  as.data.frame(cbind(name, text, type), stringsAsFactors = FALSE)
}

train_ham_df <- parseCorpusToDataFrame(train_ham_corpus, "ham")
train_spam_df <- parseCorpusToDataFrame(train_spam_corpus, "spam")
train_df <- rbind(train_ham_df, train_spam_df)
train_df$type <- as.factor(train_df$type)

test_ham_df <- parseCorpusToDataFrame(test_ham_corpus, "ham")
test_spam_df <- parseCorpusToDataFrame(test_spam_corpus, "spam")
test_df <- rbind(test_ham_df, test_spam_df)
test_df$type <- as.factor(test_df$type)

#===========================================================================================================================================

# GET TRAIN AND TEST LABELS

train_labels <- train_df$type
test_labels <- test_df$type

#===========================================================================================================================================

# PARSE COMBINED DF BACK TO CORPUS

train_corpus <- SimpleCorpus(VectorSource(train_df$text))
test_corpus <- SimpleCorpus(VectorSource(test_df$text))

#===========================================================================================================================================

# CLEAN TEXT AND PARSE TO DTM

customStopWords <- c(stopwords("english"), "to", "cc", "bcc", "subject", "re", "from", "can", "will")
train_dtm <- DocumentTermMatrix(train_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, removePunctuation = TRUE, stopwords = customStopWords, stemming = TRUE))
test_dtm <- DocumentTermMatrix(test_corpus, control = list(tolower = TRUE, removeNumbers = TRUE, removePunctuation = TRUE, stopwords = customStopWords, stemming = TRUE))

#===========================================================================================================================================

# EXCLUDE WORDS WHERE FREQ < 5

train_terms_gt_freq_min <- findFreqTerms(train_dtm, 5)
test_terms_gt_freq_min <- findFreqTerms(test_dtm, 5)

train_dtm_freq <- train_dtm[,train_terms_gt_freq_min]
test_dtm_freq <- test_dtm[,test_terms_gt_freq_min]

#===========================================================================================================================================

# CONVERT DTM TO DOCUMENT TERM DATAFRAME WITH FILENAMES AND LABELS

train_dtdf <- as.data.frame(cbind(train_df, as.data.frame(as.matrix(train_dtm_freq))))
test_dtdf <- as.data.frame(cbind(test_df, as.data.frame(as.matrix(test_dtm_freq))))

#===========================================================================================================================================

# WORD CLOUDS

colorPalette <- brewer.pal(8, "Dark2")

train_ham_freqs <- colSums(subset(train_dtdf, type == "ham")[,4:ncol(train_dtdf)])
train_ham_terms <- names(train_ham_freqs)
train_ham_terms_freqs <- data.frame(word = train_ham_terms, freq = train_ham_freqs)
png("train_ham_wc.png", width=1280, height=800)
wordcloud(words = train_ham_terms_freqs$word, freq = train_ham_terms_freqs$freq, max.words = 50, min.freq = 2, rot.per = 0.15, scale = c(3, 0.5), random.order = FALSE, colors = colorPalette)
dev.off()

train_spam_freqs <- colSums(subset(train_dtdf, type == "spam")[,4:ncol(train_dtdf)])
train_spam_terms <- names(train_spam_freqs)
train_spam_terms_freqs <- data.frame(word = train_spam_terms, freq = train_spam_freqs)
png("train_spam_wc.png", width=1280, height=800)
wordcloud(words = train_spam_terms_freqs$word, freq = train_spam_terms_freqs$freq, max.words = 50, min.freq = 2, rot.per = 0.15, scale = c(3, 0.5), random.order = FALSE, colors = colorPalette)
dev.off()



