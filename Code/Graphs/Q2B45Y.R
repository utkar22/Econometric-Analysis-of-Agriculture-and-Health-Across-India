#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\datafile Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Getting data for fever for years 2011, 2012, 2013, 2014, 2015, 2016
fever2011 <- subset(datafile$v45, datafile$year == 2011)
fever2012 <- subset(datafile$v45, datafile$year == 2012)
fever2013 <- subset(datafile$v45, datafile$year == 2013)
fever2014 <- subset(datafile$v45, datafile$year == 2014)
fever2015 <- subset(datafile$v45, datafile$year == 2015)
fever2016 <- subset(datafile$v45, datafile$year == 2016)


#Plotting the histogram
hist(fever2011, xlab = "fever", ylab = "Frequency",main = "Histogram",col = "blue")
hist(fever2012, xlab = "fever", ylab = "Frequency",main = "Histogram", add = TRUE,col = "red")
hist(fever2013, xlab = "fever", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(fever2014, xlab = "fever", ylab = "Frequency",main = "Histogram", add = TRUE,col = "yellow")
hist(fever2015, xlab = "fever", ylab = "Frequency",main = "Histogram", add = TRUE,col = "orange")
hist(fever2016, xlab = "fever", ylab = "Frequency",main = "Histogram", add = TRUE,col = "black")
