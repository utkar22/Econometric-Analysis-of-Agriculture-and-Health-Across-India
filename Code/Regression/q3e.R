#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

gdp <- c()
beds <- c()
tap <- c()
fever <- c()

yigr_cereal = c()
yigr_cc = c()
yigr_cash = c()
yigr_oil = c()
yigr_hort = c()

for(i in 2:nrow(datafile)){ 
	if ((datafile[i,7]-datafile[i-1,7]==1) && (datafile[i,6]==datafile[i-1,6])
	 && (datafile[i,63]==datafile[i-1,63])){
		gr <- ((datafile[i,69]-datafile[i-1,69])/datafile[i-1,69])
		if (!is.na(gr) && !is.infinite(gr)){
			if (datafile[i,63] != "Pulse"){
				gdp = append(gdp, datafile[i,70])
				beds = append(beds, datafile[i,71])
				tap = append(tap, datafile[i,72])

				fever = append(fever, datafile[i,58])

				if (datafile[i,63] == "Cereal"){
					yigr_cereal = append(yigr_cereal, gr)
					yigr_cc = append(yigr_cc, 0)
					yigr_cash = append(yigr_cash, 0)
					yigr_oil = append(yigr_oil, 0)
					yigr_hort = append(yigr_hort, 0)
				}
				else if (datafile[i,63] == "Coarse Cereal"){
					yigr_cereal = append(yigr_cereal, 0)
					yigr_cc = append(yigr_cc, gr)
					yigr_cash = append(yigr_cash, 0)
					yigr_oil = append(yigr_oil, 0)
					yigr_hort = append(yigr_hort, 0)
				}
				else if (datafile[i,63] == "Cash"){
					yigr_cereal = append(yigr_cereal, 0)
					yigr_cc = append(yigr_cc, 0)
					yigr_cash = append(yigr_cash, gr)
					yigr_oil = append(yigr_oil, 0)
					yigr_hort = append(yigr_hort, 0)
				}
				else if (datafile[i,63] == "Oilseed"){
					yigr_cereal = append(yigr_cereal, 0)
					yigr_cc = append(yigr_cc, 0)
					yigr_cash = append(yigr_cash, 0)
					yigr_oil = append(yigr_oil, gr)
					yigr_hort = append(yigr_hort, 0)
				}
				else if (datafile[i,63] == "Horticulture"){
					yigr_cereal = append(yigr_cereal, 0)
					yigr_cc = append(yigr_cc, 0)
					yigr_cash = append(yigr_cash, 0)
					yigr_oil = append(yigr_oil, 0)
					yigr_hort = append(yigr_hort, gr)
				}
			}
		}
	}
}

model5 = lm(fever~gdp+beds+tap+yigr_cereal+yigr_cc+yigr_cash+yigr_oil+yigr_hort)

length(fever)
print(model5)
summary(model5)
