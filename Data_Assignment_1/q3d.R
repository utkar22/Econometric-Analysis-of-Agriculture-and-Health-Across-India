#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

gdp <- c()
beds <- c()
tap <- c()
yigr <- c()
fever <- c()

for(i in 2:nrow(datafile)){ 
	if ((datafile[i,7]-datafile[i-1,7]==1) && (datafile[i,6]==datafile[i-1,6]) && (datafile[i,63]==datafile[i-1,63])){
		if (datafile[i,63]!="Pulse"){
			gr <- ((datafile[i,69]-datafile[i-1,69])/datafile[i-1,69])
			gdp_data = datafile[i,70]
			beds_data = datafile[i,71]
			tap_data = datafile[i,72]
			fever_data = datafile[i,58]

			if (!(is.na(gr)) && !(is.na(gdp_data)) && !(is.na(beds_data)) &&
			    !(is.na(tap_data)) && !(is.na(fever_data)) && !(is.infinite(gr))){
				yigr = append(yigr, gr)

				gdp = append(gdp, datafile[i,70])
				beds = append(beds, datafile[i,71])
				tap = append(tap, datafile[i,72])

				fever = append(fever, datafile[i,58])
			}
		}
	}
}

model4 = lm(fever~gdp+beds+tap+yigr)

length(fever)
summary(model4)
