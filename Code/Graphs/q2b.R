remove_outliers <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

y <- subset(datafile$v40,datafile$year == 2011)
#y <- remove_outliers(y)

y2 <- subset(datafile$v41,datafile$year == 2011)
y2 <- remove_outliers(y2)

hist(y, col='red', breaks = 50)
#hist(y2, col='blue', breaks = 50, add=TRUE)
