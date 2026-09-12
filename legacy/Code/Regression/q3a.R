#Question 3 Regression Model A
#Utkarsh Arora 2020143

#Opening the csv file
datafile <- read.csv("data/raw/main_final.csv")

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
