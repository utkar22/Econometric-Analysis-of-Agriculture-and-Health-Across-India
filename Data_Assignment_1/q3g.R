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

yi_cereal = c()
yi_cc = c()
yi_cash = c()
yi_oil = c()
yi_hort = c()

for(i in 1:nrow(datafile)){
	gdp_data = datafile[i,70]
	beds_data = datafile[i,71]
	tap_data = datafile[i,72]
	yi = datafile[i,69]

	fever_data = datafile[i,58]

	if (!is.na(gdp_data) && !is.na(beds_data) && !is.na(tap_data) && (gdp_data>0) && (beds_data>0) && (tap_data>0) && (yi>0) && (datafile[i,63]!="Pulse")){
		gdp = append(gdp,gdp_data)
		beds = append(beds, beds_data)
		tap = append(tap, tap_data)
		fever = append(fever, fever_data)

		if (datafile[i,63] == "Cereal"){
			yi_cereal = append(yi_cereal, yi)
			yi_cc = append(yi_cc, 1)
			yi_cash = append(yi_cash, 1)
			yi_oil = append(yi_oil, 1)
			yi_hort = append(yi_hort, 1)
		}
		else if (datafile[i,63] == "Coarse Cereal"){
			yi_cereal = append(yi_cereal, 1)
			yi_cc = append(yi_cc, yi)
			yi_cash = append(yi_cash, 1)
			yi_oil = append(yi_oil, 1)
			yi_hort = append(yi_hort, 1)
		}
		else if (datafile[i,63] == "Cash"){
			yi_cereal = append(yi_cereal, 1)
			yi_cc = append(yi_cc, 1)
			yi_cash = append(yi_cash, yi)
			yi_oil = append(yi_oil, 1)
			yi_hort = append(yi_hort, 1)
		}
		else if (datafile[i,63] == "Oilseed"){
			yi_cereal = append(yi_cereal, 1)
			yi_cc = append(yi_cc, 1)
			yi_cash = append(yi_cash, 1)
			yi_oil = append(yi_oil, yi)
			yi_hort = append(yi_hort, 1)
		}
		else if (datafile[i,63] == "Horticulture"){
			yi_cereal = append(yi_cereal, 1)
			yi_cc = append(yi_cc, 1)
			yi_cash = append(yi_cash, 1)
			yi_oil = append(yi_oil, 1)
			yi_hort = append(yi_hort, yi)
		}
	}
}

model7 <- lm(fever~log(gdp)+log(beds)+log(tap)+log(yi_cereal)+log(yi_cc)+log(yi_cash)+log(yi_oil)+log(yi_hort))

length(fever)
summary(model7)
