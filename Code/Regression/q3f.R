#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Storing the columns as variables
#All districts and years are included 
#Cereals, Coarse Cereals, Cash, Oilseed, Horticulture crop categories are included
#Pulse crops are excluded

gdp <- c()
beds <- c()
tap <- c()
fever <- c()
yield_index <- c()

for (i in 1:nrow(datafile)){
	gdp_data = datafile[i,70]
	beds_data = datafile[i,71]
	tap_data = datafile[i,72]
	yi_data = datafile[i,69]

	fever_data = datafile[i,58]

	if (!is.na(gdp_data) && !is.na(beds_data) && !is.na(tap_data) && !is.na(yi_data) && !is.na(fever_data)){
		if ((gdp_data!=0)&&(beds_data!=0)&&(tap_data!=0)&&(yi_data!=0)){
			gdp = append(gdp,gdp_data)
			beds = append(beds, beds_data)
			tap = append(tap, tap_data)
			yield_index = append(yield_index, yi_data)
			fever = append(fever, fever_data)
		}
	}
}



model6 <- lm(fever~log(gdp)+log(beds)+log(tap)+log(yield_index))

length(fever)
summary(model6)
