#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

cereal_yigr = c()
cc_yigr = c()
cash_yigr = c()
oil_yigr = c()
hort_yigr = c()
pulse_yigr = c()


v40_cereal = c()
v40_cc = c()
v40_cash = c()
v40_oil = c()
v40_hort = c()
v40_pulse = c()

v42_cereal = c()
v42_cc = c()
v42_cash = c()
v42_oil = c()
v42_hort = c()
v42_pulse = c()

v43_cereal = c()
v43_cc = c()
v43_cash = c()
v43_oil = c()
v43_hort = c()
v43_pulse = c()

v44_cereal = c()
v44_cc = c()
v44_cash = c()
v44_oil = c()
v44_hort = c()
v44_pulse = c()

v45_cereal = c()
v45_cc = c()
v45_cash = c()
v45_oil = c()
v45_hort = c()
v45_pulse = c()

v46_cereal = c()
v46_cc = c()
v46_cash = c()
v46_oil = c()
v46_hort = c()
v46_pulse = c()


for(i in 2:nrow(datafile)){
	if (((datafile[i,7]-datafile[i-1,7])==1)&&(datafile[i,6]==datafile[i-1,6])&&
		(datafile[i,8]==datafile[i-1,8])&&(datafile[i,63]==datafile[i-1,63])){
		gr <- ((datafile[i,69]-datafile[i-1,69])/datafile[i-1,69])
		if (!is.na(gr) && !is.infinite(gr)){
			if (datafile[i,63]=="Cereal"){
				cereal_yigr = append(cereal_yigr,gr)

				v40_cereal = append(v40_cereal, as.numeric(datafile[i,53]))
				v42_cereal = append(v42_cereal, as.numeric(datafile[i,55]))
				v43_cereal = append(v43_cereal, as.numeric(datafile[i,56]))
				v44_cereal = append(v44_cereal, as.numeric(datafile[i,57]))
				v45_cereal = append(v45_cereal, as.numeric(datafile[i,58]))
				v46_cereal = append(v46_cereal, as.numeric(datafile[i,59]))
			}

			else if (datafile[i,63] == "Coarse Cereal"){
				cc_yigr = append(cc_yigr, gr)

				v40_cc = append(v40_cc, as.numeric(datafile[i,53]))
				v42_cc = append(v42_cc, as.numeric(datafile[i,55]))
				v43_cc = append(v43_cc, as.numeric(datafile[i,56]))
				v44_cc = append(v44_cc, as.numeric(datafile[i,57]))
				v45_cc = append(v45_cc, as.numeric(datafile[i,58]))
				v46_cc = append(v46_cc, as.numeric(datafile[i,59]))
			}

			else if (datafile[i,63] == "Cash"){
				cash_yigr = append(cash_yigr, gr)

				v40_cash = append(v40_cash, as.numeric(datafile[i,53]))
				v42_cash = append(v42_cash, as.numeric(datafile[i,55]))
				v43_cash = append(v43_cash, as.numeric(datafile[i,56]))
				v44_cash = append(v44_cash, as.numeric(datafile[i,57]))
				v45_cash = append(v45_cash, as.numeric(datafile[i,58]))
				v46_cash = append(v46_cash, as.numeric(datafile[i,59]))
			}

			else if (datafile[i,63] == "Oilseed"){
				oil_yigr = append(oil_yigr, gr)

				v40_oil = append(v40_oil, as.numeric(datafile[i,53]))
				v42_oil = append(v42_oil, as.numeric(datafile[i,55]))
				v43_oil = append(v43_oil, as.numeric(datafile[i,56]))
				v44_oil = append(v44_oil, as.numeric(datafile[i,57]))
				v45_oil = append(v45_oil, as.numeric(datafile[i,58]))
				v46_oil = append(v46_oil, as.numeric(datafile[i,59]))
			}

			else if (datafile[i,63] == "Horticulture"){
				hort_yigr = append(hort_yigr, gr)

				v40_hort = append(v40_hort, as.numeric(datafile[i,53]))
				v42_hort = append(v42_hort, as.numeric(datafile[i,55]))
				v43_hort = append(v43_hort, as.numeric(datafile[i,56]))
				v44_hort = append(v44_hort, as.numeric(datafile[i,57]))
				v45_hort = append(v45_hort, as.numeric(datafile[i,58]))
				v46_hort = append(v46_hort, as.numeric(datafile[i,59]))
			}

			else if (datafile[i,63] == "Pulse"){
				pulse_yigr = append(pulse_yigr, gr)

				v40_pulse = append(v40_pulse, as.numeric(datafile[i,53]))
				v42_pulse = append(v42_pulse, as.numeric(datafile[i,55]))
				v43_pulse = append(v43_pulse, as.numeric(datafile[i,56]))
				v44_pulse = append(v44_pulse, as.numeric(datafile[i,57]))
				v45_pulse = append(v45_pulse, as.numeric(datafile[i,58]))
				v46_pulse = append(v46_pulse, as.numeric(datafile[i,59]))
			}
		}
	}

}

v40_cash_yigr = cor(cash_yigr, v40_cash, method = "pearson", use="complete.obs")
v42_cash_yigr = cor(cash_yigr, v42_cash, method = "pearson", use="complete.obs")
v43_cash_yigr = cor(cash_yigr, v43_cash, method = "pearson", use="complete.obs")
v44_cash_yigr = cor(cash_yigr, v44_cash, method = "pearson", use="complete.obs")
v45_cash_yigr = cor(cash_yigr, v45_cash, method = "pearson", use="complete.obs")
v46_cash_yigr = cor(cash_yigr, v46_cash, method = "pearson", use="complete.obs")

v40_cereal_yigr = cor(cereal_yigr, v40_cereal, method = "pearson", use="complete.obs")
v42_cereal_yigr = cor(cereal_yigr, v42_cereal, method = "pearson", use="complete.obs")
v43_cereal_yigr = cor(cereal_yigr, v43_cereal, method = "pearson", use="complete.obs")
v44_cereal_yigr = cor(cereal_yigr, v44_cereal, method = "pearson", use="complete.obs")
v45_cereal_yigr = cor(cereal_yigr, v45_cereal, method = "pearson", use="complete.obs")
v46_cereal_yigr = cor(cereal_yigr, v46_cereal, method = "pearson", use="complete.obs")

v40_cc_yigr = cor(cc_yigr, v40_cc, method = "pearson", use="complete.obs")
v42_cc_yigr = cor(cc_yigr, v42_cc, method = "pearson", use="complete.obs")
v43_cc_yigr = cor(cc_yigr, v43_cc, method = "pearson", use="complete.obs")
v44_cc_yigr = cor(cc_yigr, v44_cc, method = "pearson", use="complete.obs")
v45_cc_yigr = cor(cc_yigr, v45_cc, method = "pearson", use="complete.obs")
v46_cc_yigr = cor(cc_yigr, v46_cc, method = "pearson", use="complete.obs")

v40_oil_yigr = cor(oil_yigr, v40_oil, method = "pearson", use="complete.obs")
v42_oil_yigr = cor(oil_yigr, v42_oil, method = "pearson", use="complete.obs")
v43_oil_yigr = cor(oil_yigr, v43_oil, method = "pearson", use="complete.obs")
v44_oil_yigr = cor(oil_yigr, v44_oil, method = "pearson", use="complete.obs")
v45_oil_yigr = cor(oil_yigr, v45_oil, method = "pearson", use="complete.obs")
v46_oil_yigr = cor(oil_yigr, v46_oil, method = "pearson", use="complete.obs")

v40_hort_yigr = cor(hort_yigr, v40_hort, method = "pearson", use="complete.obs")
v42_hort_yigr = cor(hort_yigr, v42_hort, method = "pearson", use="complete.obs")
v43_hort_yigr = cor(hort_yigr, v43_hort, method = "pearson", use="complete.obs")
v44_hort_yigr = cor(hort_yigr, v44_hort, method = "pearson", use="complete.obs")
v45_hort_yigr = cor(hort_yigr, v45_hort, method = "pearson", use="complete.obs")
v46_hort_yigr = cor(hort_yigr, v46_hort, method = "pearson", use="complete.obs")

v40_pulse_yigr = cor(pulse_yigr, v40_pulse, method = "pearson", use="complete.obs")
v42_pulse_yigr = cor(pulse_yigr, v42_pulse, method = "pearson", use="complete.obs")
v43_pulse_yigr = cor(pulse_yigr, v43_pulse, method = "pearson", use="complete.obs")
v44_pulse_yigr = cor(pulse_yigr, v44_pulse, method = "pearson", use="complete.obs")
v45_pulse_yigr = cor(pulse_yigr, v45_pulse, method = "pearson", use="complete.obs")
v46_pulse_yigr = cor(pulse_yigr, v46_pulse, method = "pearson", use="complete.obs")



Variable <- c("sepsis","lbw","pneumonia","diarrhea","fever","measles")
Cash_Crops <- c(v40_cash_yigr, v42_cash_yigr, v43_cash_yigr, v44_cash_yigr, v45_cash_yigr, v46_cash_yigr)
Cereal_Crops <- c(v40_cereal_yigr, v42_cereal_yigr, v43_cereal_yigr, v44_cereal_yigr, v45_cereal_yigr, v46_cereal_yigr)
Horticulture_Crops <- c(v40_hort_yigr, v42_hort_yigr, v43_hort_yigr, v44_hort_yigr, v45_hort_yigr, v46_hort_yigr)
Pulse_Crops <- c(v40_pulse_yigr, v42_pulse_yigr, v43_pulse_yigr, v44_pulse_yigr, v45_pulse_yigr, v46_pulse_yigr)
Oilseed_Crops <- c(v40_oil_yigr, v42_oil_yigr, v43_oil_yigr, v44_oil_yigr, v45_oil_yigr, v46_oil_yigr)
Coarse_Cereal_Crops <- c(v40_cc_yigr, v42_cc_yigr, v43_cc_yigr, v44_cc_yigr, v45_cc_yigr, v46_cc_yigr)

new_df <- data.frame(Variable, Cash_Crops, Cereal_Crops, Horticulture_Crops, Pulse_Crops, Oilseed_Crops, Coarse_Cereal_Crops)
print(new_df)
