#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\datafile Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

fever_rabi <- subset(datafile$v45, datafile$season == "Rabi")
fever_kharif <- subset(datafile$v45, datafile$season == "Kharif")
fever_summer <- subset(datafile$v45, datafile$season == "Summer")
fever_wholeyear <- subset(datafile$v45, datafile$season == "Whole Year")

hist(fever_rabi, xlab = "fever", ylab = "Frequency",main = "Histogram", col="blue")
hist(fever_kharif, xlab = "fever", ylab = "Frequency",main = "Histogram", add = TRUE, col="red")
hist(fever_wholeyear, xlab = "fever", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(fever_summer, xlab = "fever", ylab = "Frequency",main = "Histogram", add = TRUE,col="yellow")

