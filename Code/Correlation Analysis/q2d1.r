#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Calculating the correlation coefficient between the independent and the dependent variables
gdp_v40 = cor(datafile$gdp, datafile$v40, method = "pearson", use="complete.obs")
beds_v40 = cor(datafile$beds,datafile$v40, method = "pearson", use="complete.obs")
tap_v40 = cor(datafile$tap, datafile$v40, method = "pearson", use="complete.obs")
print(sum(is.na(datafile$tap)))

gdp_v42 = cor(datafile$gdp, datafile$v42, method = "pearson", use="complete.obs")
beds_v42 = cor(datafile$beds,datafile$v42, method = "pearson", use="complete.obs")
tap_v42 = cor(datafile$tap, datafile$v42, method = "pearson", use="complete.obs")

gdp_v43 = cor(datafile$gdp, datafile$v43, method = "pearson", use="complete.obs")
beds_v43 = cor(datafile$beds,datafile$v43, method = "pearson", use="complete.obs")
tap_v43 = cor(datafile$tap, datafile$v43, method = "pearson", use="complete.obs")

gdp_v44 = cor(datafile$gdp, datafile$v44, method = "pearson", use="complete.obs")
beds_v44 = cor(datafile$beds,datafile$v44, method = "pearson", use="complete.obs")
tap_v44 = cor(datafile$tap, datafile$v44, method = "pearson", use="complete.obs")

gdp_v45 = cor(datafile$gdp, datafile$v45, method = "pearson", use="complete.obs")
beds_v45 = cor(datafile$beds,datafile$v45, method = "pearson", use="complete.obs")
tap_v45 = cor(datafile$tap, datafile$v45, method = "pearson", use="complete.obs")

gdp_v46 = cor(datafile$gdp, datafile$v46, method = "pearson", use="complete.obs")
beds_v46 = cor(datafile$beds,datafile$v46, method = "pearson", use="complete.obs")
tap_v46 = cor(datafile$tap, datafile$v46, method = "pearson", use="complete.obs")

#Creating a new data frame to print these values in tabular form
Variable <- c("sepsis","lbw","pneumonia","diarrhea","fever","measles")
GDP <- c(gdp_v40, gdp_v42, gdp_v43, gdp_v44, gdp_v45, gdp_v46)
BEDS <- c(beds_v40, beds_v42, beds_v43, beds_v44, beds_v45, beds_v46)
TAP <- c(tap_v40, tap_v42, tap_v43, tap_v44, tap_v45, tap_v46)

new_df <- data.frame(Variable, GDP, BEDS, TAP)
print(new_df)
