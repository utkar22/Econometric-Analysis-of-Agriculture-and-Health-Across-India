#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Storing the columns as variables
#All districts and years are included 
#Cereals, Coarse Cereals, Cash, Oilseed, Horticulture crop categories are included
#Pulse crops are excluded
gdp <- subset(datafile$gdp, datafile$cropcategory != "Pulse")
beds <- subset(datafile$beds, datafile$cropcategory != "Pulse")
tap <- subset(datafile$tap, datafile$cropcategory != "Pulse")

yi_cereal = c()
yi_cc = c()
yi_cash = c()
yi_oil = c()
yi_hort = c()

for(i in 1:nrow(datafile)){
	if (datafile[i,63] == "Cereal"){
		yi_cereal = append(yi_cereal, as.numeric(datafile[i,69]))

		yi_cc = append(yi_cc, 0)
		yi_cash = append(yi_cash, 0)
		yi_oil = append(yi_oil, 0)
		yi_hort = append(yi_hort, 0)
	}
	else if (datafile[i,63] == "Coarse Cereal"){
		yi_cc = append(yi_cc, as.numeric(datafile[i,69]))

		yi_cereal = append(yi_cereal, 0)
		yi_cash = append(yi_cash, 0)
		yi_oil = append(yi_oil, 0)
		yi_hort = append(yi_hort, 0)
	}
	else if (datafile[i,63] == "Cash"){
		yi_cash = append(yi_cash, as.numeric(datafile[i,69]))

		yi_cereal = append(yi_cereal, 0)
		yi_cc = append(yi_cc, 0)
		yi_oil = append(yi_oil, 0)
		yi_hort = append(yi_hort, 0)
	}
	else if (datafile[i,63] == "Oilseed"){
		yi_oil = append(yi_oil, as.numeric(datafile[i,69]))

		yi_cereal = append(yi_cereal, 0)
		yi_cc = append(yi_cc, 0)
		yi_cash = append(yi_cash, 0)
		yi_hort = append(yi_hort, 0)
	}
	else if (datafile[i,63] == "Horticulture"){
		yi_hort = append(yi_hort, as.numeric(datafile[i,69]))

		yi_cereal = append(yi_cereal, 0)
		yi_cc = append(yi_cc, 0)
		yi_cash = append(yi_cash, 0)
		yi_oil = append(yi_oil, 0)
	}
}

fever <- subset(datafile$v45, datafile$cropcategory != "Pulse")


model3 <- lm(fever~gdp+beds+tap+yi_cereal+yi_cc+yi_cash+yi_oil+yi_hort)

length(fever)
summary(model3)
