#Opening the csv file
datafile <- read.csv("data/raw/main_final.csv")

sepsis_rabi <- subset(datafile$v40, datafile$season == "Rabi")
sepsis_kharif <- subset(datafile$v40, datafile$season == "Kharif")
sepsis_summer <- subset(datafile$v40, datafile$season == "Summer")
sepsis_wholeyear <- subset(datafile$v40, datafile$season == "Whole Year")

hist(sepsis_rabi, xlab = "sepsis", ylab = "Frequency",main = "Histogram", col="blue")
hist(sepsis_kharif, xlab = "sepsis", ylab = "Frequency",main = "Histogram", add = TRUE, col="red")
hist(sepsis_wholeyear, xlab = "sepsis", ylab = "Frequency",main = "Histogram", add = TRUE,col="green")
hist(sepsis_summer, xlab = "sepsis", ylab = "Frequency",main = "Histogram", add = TRUE,col="yellow")

