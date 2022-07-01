#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\datafile Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Getting data for measles for years 2011, 2012, 2013, 2014, 2015, 2016
measles2011 <- subset(datafile$v46, datafile$year == 2011)
measles2012 <- subset(datafile$v46, datafile$year == 2012)
measles2013 <- subset(datafile$v46, datafile$year == 2013)
measles2014 <- subset(datafile$v46, datafile$year == 2014)
measles2015 <- subset(datafile$v46, datafile$year == 2015)
measles2016 <- subset(datafile$v46, datafile$year == 2016)


#Plotting the histogram
hist(measles2011, xlab = "measles", ylab = "Frequency",main = "Histogram",col = "blue")
hist(measles2012, xlab = "measles", ylab = "Frequency",main = "Histogram", add = TRUE,col = "red")
hist(measles2013, xlab = "measles", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(measles2014, xlab = "measles", ylab = "Frequency",main = "Histogram", add = TRUE,col = "yellow")
hist(measles2015, xlab = "measles", ylab = "Frequency",main = "Histogram", add = TRUE,col = "orange")
hist(measles2016, xlab = "measles", ylab = "Frequency",main = "Histogram", add = TRUE,col = "black")
