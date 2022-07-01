#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")


cash_yi = subset(datafile$index, datafile$cropcategory == "Cash")
v40_cash = subset(datafile$v40, datafile$cropcategory == "Cash")
v40_cash_yi = cor(cash_yi, v40_cash, method = "pearson", use="complete.obs")

cash_yi = subset(datafile$index, datafile$cropcategory == "Cash")
v42_cash = subset(datafile$v42, datafile$cropcategory == "Cash")
v42_cash_yi = cor(cash_yi, v42_cash, method = "pearson", use="complete.obs")

cash_yi = subset(datafile$index, datafile$cropcategory == "Cash")
v43_cash = subset(datafile$v43, datafile$cropcategory == "Cash")
v43_cash_yi = cor(cash_yi, v43_cash, method = "pearson", use="complete.obs")

cash_yi = subset(datafile$index, datafile$cropcategory == "Cash")
v44_cash = subset(datafile$v44, datafile$cropcategory == "Cash")
v44_cash_yi = cor(cash_yi, v44_cash, method = "pearson", use="complete.obs")

cash_yi = subset(datafile$index, datafile$cropcategory == "Cash")
v45_cash = subset(datafile$v45, datafile$cropcategory == "Cash")
v45_cash_yi = cor(cash_yi, v45_cash, method = "pearson", use="complete.obs")

cash_yi = subset(datafile$index, datafile$cropcategory == "Cash")
v46_cash = subset(datafile$v46, datafile$cropcategory == "Cash")
v46_cash_yi = cor(cash_yi, v46_cash, method = "pearson", use="complete.obs")


cereal_yi = subset(datafile$index, datafile$cropcategory == "Cereal")
v40_cereal = subset(datafile$v40, datafile$cropcategory == "Cereal")
v40_cereal_yi = cor(cereal_yi, v40_cereal, method = "pearson", use="complete.obs")

cereal_yi = subset(datafile$index, datafile$cropcategory == "Cereal")
v42_cereal = subset(datafile$v42, datafile$cropcategory == "Cereal")
v42_cereal_yi = cor(cereal_yi, v42_cereal, method = "pearson", use="complete.obs")

cereal_yi = subset(datafile$index, datafile$cropcategory == "Cereal")
v43_cereal = subset(datafile$v43, datafile$cropcategory == "Cereal")
v43_cereal_yi = cor(cereal_yi, v43_cereal, method = "pearson", use="complete.obs")

cereal_yi = subset(datafile$index, datafile$cropcategory == "Cereal")
v44_cereal = subset(datafile$v44, datafile$cropcategory == "Cereal")
v44_cereal_yi = cor(cereal_yi, v44_cereal, method = "pearson", use="complete.obs")

cereal_yi = subset(datafile$index, datafile$cropcategory == "Cereal")
v45_cereal = subset(datafile$v45, datafile$cropcategory == "Cereal")
v45_cereal_yi = cor(cereal_yi, v45_cereal, method = "pearson", use="complete.obs")

cereal_yi = subset(datafile$index, datafile$cropcategory == "Cereal")
v46_cereal = subset(datafile$v46, datafile$cropcategory == "Cereal")
v46_cereal_yi = cor(cereal_yi, v46_cereal, method = "pearson", use="complete.obs")


horticulture_yi = subset(datafile$index, datafile$cropcategory == "Horticulture")
v40_horticulture = subset(datafile$v40, datafile$cropcategory == "Horticulture")
v40_horticulture_yi = cor(horticulture_yi, v40_horticulture, method = "pearson", use="complete.obs")

horticulture_yi = subset(datafile$index, datafile$cropcategory == "Horticulture")
v42_horticulture = subset(datafile$v42, datafile$cropcategory == "Horticulture")
v42_horticulture_yi = cor(horticulture_yi, v42_horticulture, method = "pearson", use="complete.obs")

horticulture_yi = subset(datafile$index, datafile$cropcategory == "Horticulture")
v43_horticulture = subset(datafile$v43, datafile$cropcategory == "Horticulture")
v43_horticulture_yi = cor(horticulture_yi, v43_horticulture, method = "pearson", use="complete.obs")

horticulture_yi = subset(datafile$index, datafile$cropcategory == "Horticulture")
v44_horticulture = subset(datafile$v44, datafile$cropcategory == "Horticulture")
v44_horticulture_yi = cor(horticulture_yi, v44_horticulture, method = "pearson", use="complete.obs")

horticulture_yi = subset(datafile$index, datafile$cropcategory == "Horticulture")
v45_horticulture = subset(datafile$v45, datafile$cropcategory == "Horticulture")
v45_horticulture_yi = cor(horticulture_yi, v45_horticulture, method = "pearson", use="complete.obs")

horticulture_yi = subset(datafile$index, datafile$cropcategory == "Horticulture")
v46_horticulture = subset(datafile$v46, datafile$cropcategory == "Horticulture")
v46_horticulture_yi = cor(horticulture_yi, v46_horticulture, method = "pearson", use="complete.obs")


pulse_yi = subset(datafile$index, datafile$cropcategory == "Pulse")
v40_pulse = subset(datafile$v40, datafile$cropcategory == "Pulse")
v40_pulse_yi = cor(pulse_yi, v40_pulse, method = "pearson", use="complete.obs")

pulse_yi = subset(datafile$index, datafile$cropcategory == "Pulse")
v42_pulse = subset(datafile$v42, datafile$cropcategory == "Pulse")
v42_pulse_yi = cor(pulse_yi, v42_pulse, method = "pearson", use="complete.obs")

pulse_yi = subset(datafile$index, datafile$cropcategory == "Pulse")
v43_pulse = subset(datafile$v43, datafile$cropcategory == "Pulse")
v43_pulse_yi = cor(pulse_yi, v43_pulse, method = "pearson", use="complete.obs")

pulse_yi = subset(datafile$index, datafile$cropcategory == "Pulse")
v44_pulse = subset(datafile$v44, datafile$cropcategory == "Pulse")
v44_pulse_yi = cor(pulse_yi, v44_pulse, method = "pearson", use="complete.obs")

pulse_yi = subset(datafile$index, datafile$cropcategory == "Pulse")
v45_pulse = subset(datafile$v45, datafile$cropcategory == "Pulse")
v45_pulse_yi = cor(pulse_yi, v45_pulse, method = "pearson", use="complete.obs")

pulse_yi = subset(datafile$index, datafile$cropcategory == "Pulse")
v46_pulse = subset(datafile$v46, datafile$cropcategory == "Pulse")
v46_pulse_yi = cor(pulse_yi, v46_pulse, method = "pearson", use="complete.obs")


oilseed_yi = subset(datafile$index, datafile$cropcategory == "Oilseed")
v40_oilseed = subset(datafile$v40, datafile$cropcategory == "Oilseed")
v40_oilseed_yi = cor(oilseed_yi, v40_oilseed, method = "pearson", use="complete.obs")

oilseed_yi = subset(datafile$index, datafile$cropcategory == "Oilseed")
v42_oilseed = subset(datafile$v42, datafile$cropcategory == "Oilseed")
v42_oilseed_yi = cor(oilseed_yi, v42_oilseed, method = "pearson", use="complete.obs")

oilseed_yi = subset(datafile$index, datafile$cropcategory == "Oilseed")
v43_oilseed = subset(datafile$v43, datafile$cropcategory == "Oilseed")
v43_oilseed_yi = cor(oilseed_yi, v43_oilseed, method = "pearson", use="complete.obs")

oilseed_yi = subset(datafile$index, datafile$cropcategory == "Oilseed")
v44_oilseed = subset(datafile$v44, datafile$cropcategory == "Oilseed")
v44_oilseed_yi = cor(oilseed_yi, v44_oilseed, method = "pearson", use="complete.obs")

oilseed_yi = subset(datafile$index, datafile$cropcategory == "Oilseed")
v45_oilseed = subset(datafile$v45, datafile$cropcategory == "Oilseed")
v45_oilseed_yi = cor(oilseed_yi, v45_oilseed, method = "pearson", use="complete.obs")

oilseed_yi = subset(datafile$index, datafile$cropcategory == "Oilseed")
v46_oilseed = subset(datafile$v46, datafile$cropcategory == "Oilseed")
v46_oilseed_yi = cor(oilseed_yi, v46_oilseed, method = "pearson", use="complete.obs")


coarse_cereal_yi = subset(datafile$index, datafile$cropcategory == "Coarse Cereal")
v40_coarse_cereal = subset(datafile$v40, datafile$cropcategory == "Coarse Cereal")
v40_coarse_cereal_yi = cor(coarse_cereal_yi, v40_coarse_cereal, method = "pearson", use="complete.obs")

coarse_cereal_yi = subset(datafile$index, datafile$cropcategory == "Coarse Cereal")
v42_coarse_cereal = subset(datafile$v42, datafile$cropcategory == "Coarse Cereal")
v42_coarse_cereal_yi = cor(coarse_cereal_yi, v42_coarse_cereal, method = "pearson", use="complete.obs")

coarse_cereal_yi = subset(datafile$index, datafile$cropcategory == "Coarse Cereal")
v43_coarse_cereal = subset(datafile$v43, datafile$cropcategory == "Coarse Cereal")
v43_coarse_cereal_yi = cor(coarse_cereal_yi, v43_coarse_cereal, method = "pearson", use="complete.obs")

coarse_cereal_yi = subset(datafile$index, datafile$cropcategory == "Coarse Cereal")
v44_coarse_cereal = subset(datafile$v44, datafile$cropcategory == "Coarse Cereal")
v44_coarse_cereal_yi = cor(coarse_cereal_yi, v44_coarse_cereal, method = "pearson", use="complete.obs")

coarse_cereal_yi = subset(datafile$index, datafile$cropcategory == "Coarse Cereal")
v45_coarse_cereal = subset(datafile$v45, datafile$cropcategory == "Coarse Cereal")
v45_coarse_cereal_yi = cor(coarse_cereal_yi, v45_coarse_cereal, method = "pearson", use="complete.obs")

coarse_cereal_yi = subset(datafile$index, datafile$cropcategory == "Coarse Cereal")
v46_coarse_cereal = subset(datafile$v46, datafile$cropcategory == "Coarse Cereal")
v46_coarse_cereal_yi = cor(coarse_cereal_yi, v46_coarse_cereal, method = "pearson", use="complete.obs")


Variable <- c("sepsis","lbw","pneumonia","diarrhea","fever","measles")
Cash_Crops <- c(v40_cash_yi, v42_cash_yi, v43_cash_yi, v44_cash_yi, v45_cash_yi, v46_cash_yi)
Cereal_Crops <- c(v40_cereal_yi, v42_cereal_yi, v43_cereal_yi, v44_cereal_yi, v45_cereal_yi, v46_cereal_yi)
Horticulture_Crops <- c(v40_horticulture_yi, v42_horticulture_yi, v43_horticulture_yi, v44_horticulture_yi, v45_horticulture_yi, v46_horticulture_yi)
Pulse_Crops <- c(v40_pulse_yi, v42_pulse_yi, v43_pulse_yi, v44_pulse_yi, v45_pulse_yi, v46_pulse_yi)
Oilseed_Crops <- c(v40_oilseed_yi, v42_oilseed_yi, v43_oilseed_yi, v44_oilseed_yi, v45_oilseed_yi, v46_oilseed_yi)
Coarse_Cereal_Crops <- c(v40_coarse_cereal_yi, v42_coarse_cereal_yi, v43_coarse_cereal_yi, v44_coarse_cereal_yi, v45_coarse_cereal_yi, v46_coarse_cereal_yi)

new_df <- data.frame(Variable, Cash_Crops, Cereal_Crops, Horticulture_Crops, Pulse_Crops, Oilseed_Crops, Coarse_Cereal_Crops)
print(new_df)