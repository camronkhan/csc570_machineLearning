usedcars <- read.csv("../../data/chapter2/usedcars.csv", stringsAsFactors = FALSE)

str(usedcars)
head(usedcars)
tail(usedcars)
names(usedcars)

summary(usedcars)
summary(usedcars$year)
summary(usedcars[c("price", "mileage")])

range(usedcars$price)
diff(range(usedcars$price))

iqr <- IQR(usedcars$price)

summary(usedcars$price)
left <- 11000-1.5*iqr
left
right <- 14900+1.5*iqr
right
x <- usedcars$price
x[x<left | x>right]

L <- usedcars$price==3800
usedcars[L,]

x <- usedcars$price
meanPrice <- mean(x)
sdPrice <- sd(x)
length(which(x > meanPrice - sdPrice & x < meanPrice + sdPrice))


length(which(x > 10000 & x < 15000))

table_color <- table(usedcars$color)
names(table_color)[table_color == max(table_color)]
percent_table_year <- prop.table(table_color)*100
percent_table_year

summary(usedcars$year)
temp <- table(as.vector(usedcars$year))
names(temp)[temp==max(temp)]

boxplot(usedcars$year)


plot(x = usedcars$year, y = usedcars$price)


stdev = sd(usedcars$mileage)
mean = mean(usedcars$mileage)
low = mean - stdev
high = mean + stdev
length(which(usedcars$mileage > low & usedcars$mileage < high))


install.packages("gmodels")
library(gmodels)

usedcars$conservative <- usedcars$color %in% c("Black", "Gray", "Silver", "White")
CrossTable(x = usedcars$transmission, y = usedcars$conservative, chisq=TRUE)
