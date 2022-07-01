#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\datafile Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Getting data for pneumonia for years 2011, 2012, 2013, 2014, 2015, 2016
pneumonia2011 <- subset(datafile$v43, datafile$year == 2011)
pneumonia2012 <- subset(datafile$v43, datafile$year == 2012)
pneumonia2013 <- subset(datafile$v43, datafile$year == 2013)
pneumonia2014 <- subset(datafile$v43, datafile$year == 2014)
pneumonia2015 <- subset(datafile$v43, datafile$year == 2015)
pneumonia2016 <- subset(datafile$v43, datafile$year == 2016)


#Plotting the histogram
hist(pneumonia2011, xlab = "pneumonia", ylab = "Frequency",main = "Histogram",col = "blue")
hist(pneumonia2012, xlab = "pneumonia", ylab = "Frequency",main = "Histogram", add = TRUE,col = "red")
hist(pneumonia2013, xlab = "pneumonia", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(pneumonia2014, xlab = "pneumonia", ylab = "Frequency",main = "Histogram", add = TRUE,col = "yellow")
hist(pneumonia2015, xlab = "pneumonia", ylab = "Frequency",main = "Histogram", add = TRUE,col = "orange")
hist(pneumonia2016, xlab = "pneumonia", ylab = "Frequency",main = "Histogram", add = TRUE,col = "black")
