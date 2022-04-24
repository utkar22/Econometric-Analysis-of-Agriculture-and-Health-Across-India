#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 2")

#Opening the csv file
datafile <- read.csv("main_final.csv")

#We subset the data file into two parts, one for Kharif and one for Rabi
data_kharif <- subset(datafile, datafile$season == "Kharif")
data_rabi <- subset(datafile, datafile$season == "Rabi")

v42_kharif <- data_kharif$v42
v42_rabi <- data_rabi$v42

index_kharif <- data_kharif$index
index_rabi <- data_rabi$index

model_kharif <- lm(v42_kharif~index_kharif)
model_rabi <- lm(v42_rabi~index_rabi)

res_kharif <- rstandard(model_kharif)
res_rabi <- rstandard(model_rabi)

sum(res_kharif)
sum(res_rabi)

res_into_index_kharif = res_kharif * index_kharif
res_into_index_rabi = res_rabi * index_rabi

sum(res_into_index_kharif)
sum(res_into_index_rabi)