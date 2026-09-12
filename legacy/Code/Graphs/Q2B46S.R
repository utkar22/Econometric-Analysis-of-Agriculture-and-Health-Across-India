#Opening the csv file
datafile <- read.csv("data/raw/main_final.csv")

measles_rabi <- subset(datafile$v46, datafile$season == "Rabi")
measles_kharif <- subset(datafile$v46, datafile$season == "Kharif")
measles_summer <- subset(datafile$v46, datafile$season == "Summer")
measles_wholeyear <- subset(datafile$v46, datafile$season == "Whole Year")

hist(measles_rabi, xlab = "measles", ylab = "Frequency",main = "Histogram", col="blue")
hist(measles_kharif, xlab = "measles", ylab = "Frequency",main = "Histogram", add = TRUE, col="red")
hist(measles_wholeyear, xlab = "measles", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(measles_summer, xlab = "measles", ylab = "Frequency",main = "Histogram", add = TRUE,col="yellow")

