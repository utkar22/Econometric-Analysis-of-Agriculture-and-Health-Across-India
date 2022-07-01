#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\datafile Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

lbw_rabi <- subset(datafile$v41, datafile$season == "Rabi")
lbw_kharif <- subset(datafile$v41, datafile$season == "Kharif")
lbw_summer <- subset(datafile$v41, datafile$season == "Summer")
lbw_wholeyear <- subset(datafile$v41, datafile$season == "Whole Year")

hist(lbw_rabi, xlab = "lbw", ylab = "Frequency",main = "Histogram", col="blue")
hist(lbw_kharif, xlab = "lbw", ylab = "Frequency",main = "Histogram", add = TRUE, col="red")
hist(lbw_wholeyear, xlab = "lbw", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(lbw_summer, xlab = "lbw", ylab = "Frequency",main = "Histogram", add = TRUE,col="yellow")

