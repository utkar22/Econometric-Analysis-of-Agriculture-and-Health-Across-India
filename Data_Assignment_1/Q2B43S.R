#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\datafile Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

pneumonia_rabi <- subset(datafile$v43, datafile$season == "Rabi")
pneumonia_kharif <- subset(datafile$v43, datafile$season == "Kharif")
pneumonia_summer <- subset(datafile$v43, datafile$season == "Summer")
pneumonia_wholeyear <- subset(datafile$v43, datafile$season == "Whole Year")

hist(pneumonia_rabi, xlab = "pneumonia", ylab = "Frequency",main = "Histogram", col="blue")
hist(pneumonia_kharif, xlab = "pneumonia", ylab = "Frequency",main = "Histogram", add = TRUE, col="red")
hist(pneumonia_wholeyear, xlab = "pneumonia", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(pneumonia_summer, xlab = "pneumonia", ylab = "Frequency",main = "Histogram", add = TRUE,col="yellow")
plot()
