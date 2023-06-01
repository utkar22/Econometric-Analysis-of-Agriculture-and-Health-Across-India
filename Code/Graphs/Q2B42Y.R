#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\datafile Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Getting data for lbw for years 2011, 2012, 2013, 2014, 2015, 2016
lbw2011 <- subset(datafile$v42, datafile$year == 2011)
lbw2012 <- subset(datafile$v42, datafile$year == 2012)
lbw2013 <- subset(datafile$v42, datafile$year == 2013)
lbw2014 <- subset(datafile$v42, datafile$year == 2014)
lbw2015 <- subset(datafile$v42, datafile$year == 2015)
lbw2016 <- subset(datafile$v42, datafile$year == 2016)


#Plotting the histogram
hist(lbw2011, xlab = "lbw", ylab = "Frequency",main = "Histogram",col = "blue")
hist(lbw2012, xlab = "lbw", ylab = "Frequency",main = "Histogram", add = TRUE,col = "red")
hist(lbw2013, xlab = "lbw", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(lbw2014, xlab = "lbw", ylab = "Frequency",main = "Histogram", add = TRUE,col = "yellow")
hist(lbw2015, xlab = "lbw", ylab = "Frequency",main = "Histogram", add = TRUE,col = "orange")
hist(lbw2016, xlab = "lbw", ylab = "Frequency",main = "Histogram", add = TRUE,col = "black")
