#Question 3 Regression Model A
#Utkarsh Arora 2020143

#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Storing the columns as variables
#All districts and years are included 
#All crop categories are included
gdp <- datafile$gdp
beds <- datafile$beds
tap <- datafile$tap

fever <- datafile$v45

model_v45 <- lm(fever~gdp+beds+tap)

print("Model for fever")
length(fever)
summary(model_v45)
