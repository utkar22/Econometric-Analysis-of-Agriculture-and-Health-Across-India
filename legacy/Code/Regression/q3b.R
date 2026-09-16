#Opening the csv file
datafile <- read.csv("data/raw/main_final.csv")

#Storing the columns as variables
#All districts and years are included 
#Cereals, Coarse Cereals, Cash, Oilseed, Horticulture crop categories are included
#Pulse crops are excluded
gdp <- subset(datafile$gdp, datafile$cropcategory != "Pulse")
beds <- subset(datafile$beds, datafile$cropcategory != "Pulse")
tap <- subset(datafile$tap, datafile$cropcategory != "Pulse")
yield_index <- subset(datafile$index, datafile$cropcategory != "Pulse")

fever <- subset(datafile$v45, datafile$cropcategory != "Pulse")


model2 <- lm(fever~gdp+beds+tap+yield_index)

length(fever)
summary(model2)
