#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\datafile Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Getting data for diarrhea for years 2011, 2012, 2013, 2014, 2015, 2016
diarrhea2011 <- subset(datafile$v44, datafile$year == 2011)
diarrhea2012 <- subset(datafile$v44, datafile$year == 2012)
diarrhea2013 <- subset(datafile$v44, datafile$year == 2013)
diarrhea2014 <- subset(datafile$v44, datafile$year == 2014)
diarrhea2015 <- subset(datafile$v44, datafile$year == 2015)
diarrhea2016 <- subset(datafile$v44, datafile$year == 2016)


#Plotting the histogram
hist(diarrhea2011, xlab = "diarrhea", ylab = "Frequency",main = "Histogram",col = "blue")
hist(diarrhea2012, xlab = "diarrhea", ylab = "Frequency",main = "Histogram", add = TRUE,col = "red")
hist(diarrhea2013, xlab = "diarrhea", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(diarrhea2014, xlab = "diarrhea", ylab = "Frequency",main = "Histogram", add = TRUE,col = "yellow")
hist(diarrhea2015, xlab = "diarrhea", ylab = "Frequency",main = "Histogram", add = TRUE,col = "orange")
hist(diarrhea2016, xlab = "diarrhea", ylab = "Frequency",main = "Histogram", add = TRUE,col = "black")
