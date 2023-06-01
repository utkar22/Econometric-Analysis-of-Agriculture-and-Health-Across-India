#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\datafile Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Getting data for Sepsis for years 2011, 2012, 2013, 2014, 2015, 2016
sepsis2011 <- subset(datafile$v40, datafile$year == 2011)
sepsis2012 <- subset(datafile$v40, datafile$year == 2012)
sepsis2013 <- subset(datafile$v40, datafile$year == 2013)
sepsis2014 <- subset(datafile$v40, datafile$year == 2014)
sepsis2015 <- subset(datafile$v40, datafile$year == 2015)
sepsis2016 <- subset(datafile$v40, datafile$year == 2016)


#Plotting the histogram
hist(sepsis2011, xlab = "sepsis", ylab = "Frequency",main = "Histogram",col = "blue")
hist(sepsis2012, xlab = "sepsis", ylab = "Frequency",main = "Histogram", add = TRUE,col = "red")
hist(sepsis2013, xlab = "sepsis", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(sepsis2014, xlab = "sepsis", ylab = "Frequency",main = "Histogram", add = TRUE,col = "yellow")
hist(sepsis2015, xlab = "sepsis", ylab = "Frequency",main = "Histogram", add = TRUE,col = "orange")
hist(sepsis2016, xlab = "sepsis", ylab = "Frequency",main = "Histogram", add = TRUE,col = "black")
