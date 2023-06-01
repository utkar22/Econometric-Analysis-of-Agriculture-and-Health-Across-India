#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\datafile Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

diarrhea_rabi <- subset(datafile$v44, datafile$season == "Rabi")
diarrhea_kharif <- subset(datafile$v44, datafile$season == "Kharif")
diarrhea_summer <- subset(datafile$v44, datafile$season == "Summer")
diarrhea_wholeyear <- subset(datafile$v44, datafile$season == "Whole Year")

hist(diarrhea_rabi, xlab = "diarrhea", ylab = "Frequency",main = "Histogram", col="blue")
hist(diarrhea_kharif, xlab = "diarrhea", ylab = "Frequency",main = "Histogram", add = TRUE, col="red")
hist(diarrhea_wholeyear, xlab = "diarrhea", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(diarrhea_summer, xlab = "diarrhea", ylab = "Frequency",main = "Histogram", add = TRUE,col="yellow")

