#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 2")

#Opening the csv file
datafile <- read.csv("main_final.csv")

#We subset the data file into two parts, one for Kharif and one for Rabi
data_kharif <- subset(datafile, datafile$season == "Kharif")
data_rabi <- subset(datafile, datafile$season == "Rabi")

#We clean out the datasets, by removing duplicated sdyid. This is because
#columns with duplicate sdyid have the same value for all the variables 
clean_data_kharif <- data_kharif[!duplicated(data_kharif$sdyid),]
clean_data_rabi <- data_rabi[!duplicated(data_rabi$sdyid),]

#Creating vectors for state groups

north_zone <- c("Himachal Pradesh","Punjab", "Uttarakhand","Uttar Pradesh","Haryana")
east_zone <- c("Bihar","Orissa","Jharkhand","West Bengal")
west_zone <- c("Rajasthan","Gujarat","Goa","Maharashtra")
south_zone <- c("Andhra Pradesh","Telangana","Karnataka","Kerela","Tamil Nadu")
central_zone <- c("Madhya Pradesh","Chhattisgarh")
north_east_zone <- c("Assam","Sikkim","Nagaland","Meghalaya","Manipur","Mizoram","Tripura","Arunachal Pradesh")

#We calculate the mean and standard deviation. We later use this to
#remove outliers (values above mean + 3*sd)

lbw_full_kharif <- clean_data_kharif$v42
mean_lbw_kharif = mean(lbw_full_kharif)
sd_lbw_kharif = sd(lbw_full_kharif)
upper_bound_kharif = mean_lbw_kharif + 3*sd_lbw_kharif

lbw_full_rabi <- clean_data_rabi$v42
mean_lbw_rabi = mean(lbw_full_rabi)
sd_lbw_rabi = sd(lbw_full_rabi)
upper_bound_rabi = mean_lbw_rabi + 3*sd_lbw_rabi


#We create empty vectors. These will be filled in the for loop
v42_kharif <- c()

v12_kharif <- c()
v15_kharif <- c()
v16_kharif <- c()
v25_kharif <- c()
v28_kharif <- c()
female_pct_kharif <- c()
gdp_kharif <- c()
beds_kharif <- c()
tap_kharif <- c()
cash_index_kharif <- c()
cereal_index_kharif <- c()
child_marriage_kharif <- c()
nitrate_kharif <- c()

if_north_kharif <- c()
if_east_kharif <- c()
if_west_kharif <- c()
if_south_kharif <- c()
if_central_kharif <- c()
if_north_east_kharif <- c()


v42_rabi <- c()

v12_rabi <- c()
v15_rabi <- c()
v16_rabi <- c()
v25_rabi <- c()
v28_rabi <- c()
female_pct_rabi <- c()
gdp_rabi <- c()
beds_rabi <- c()
tap_rabi <- c()
cash_index_rabi <- c()
cereal_index_rabi <- c()
child_marriage_rabi <- c()
nitrate_rabi <- c()

if_north_rabi <- c()
if_east_rabi <- c()
if_west_rabi <- c()
if_south_rabi <- c()
if_central_rabi <- c()
if_north_east_rabi <- c()

#Getting variable datas. We run seperate for loops for rabi and kharif

for (i in 1:nrow(clean_data_kharif)){
	lbw_data <- clean_data_kharif[i,13+42]

	female_pct <- ((clean_data_kharif[i,13+31])/(1000+clean_data_kharif[i,13+31])) * 100
	
	gdp_data <- clean_data_kharif[i,70]
	beds_data <- clean_data_kharif[i,71]
	tap_data <- clean_data_kharif[i,72]
	
	index <- clean_data_kharif[i,69]
	category <- clean_data_kharif[i,63]
	
	child_marriage_data <- clean_data_kharif[i,73]
	nitrate_data <- clean_data_kharif[i,74]

	state <- clean_data_kharif[i,4]

	if ((lbw_data<upper_bound_kharif) && !is.na(gdp_data) && !is.na(beds_data) && !is.na(tap_data) &&
	    (gdp_data!=0) && (beds_data!=0) && (tap_data!=0) && !is.na(child_marriage_data) 
	    && !is.na(nitrate_data)){

		v42_kharif = append(v42_kharif, lbw_data)

		v12_kharif = append(v12_kharif, clean_data_kharif[i,13+12])
		v15_kharif = append(v15_kharif, clean_data_kharif[i,13+15])
		v16_kharif = append(v16_kharif, clean_data_kharif[i,13+16])
		v25_kharif = append(v25_kharif, clean_data_kharif[i,13+25])
		v28_kharif = append(v28_kharif, clean_data_kharif[i,13+28])
		#v31_kharif = append(v31_kharif, clean_data_kharif[i,13+31]/10)
		female_pct_kharif = append(female_pct_kharif, female_pct)
		
		gdp_kharif = append(gdp_kharif, gdp_data)
		beds_kharif = append(beds_kharif, beds_data)
		tap_kharif = append(tap_kharif, tap_data)
		
		child_marriage_kharif = append(child_marriage_kharif, child_marriage_data)
		nitrate_kharif = append(nitrate_kharif, nitrate_data)
		
		if (category=="Cash"){
		  cash_index_kharif = append(cash_index_kharif, index)
		  cereal_index_kharif = append(cereal_index_kharif, 0)
		} else if (category == "Cereal"){
		  cash_index_kharif = append(cash_index_kharif, 0)
		  cereal_index_kharif = append(cereal_index_kharif, index)
		} else{
		  cash_index_kharif = append(cash_index_kharif, 0)
		  cereal_index_kharif = append(cereal_index_kharif, 0)
		}
		
		if (state %in% north_zone){
			if_north_kharif = append(if_north_kharif, 1)
		} else{
			if_north_kharif = append(if_north_kharif, 0)
		}

		if (state %in% east_zone){
			if_east_kharif = append(if_east_kharif, 1)
		} else{
			if_east_kharif = append(if_east_kharif, 0)
		}

		if (state %in% west_zone){
			if_west_kharif = append(if_west_kharif, 1)
		} else{
			if_west_kharif = append(if_west_kharif, 0)
		}

		if (state %in% south_zone){
			if_south_kharif = append(if_south_kharif, 1)
		} else{
			if_south_kharif = append(if_south_kharif, 0)
		}

		if (state %in% central_zone){
			if_central_kharif = append(if_central_kharif, 1)
		} else{
			if_central_kharif = append(if_central_kharif, 0)
		}

		if (state %in% north_east_zone){
			if_north_east_kharif = append(if_north_east_kharif, 1)
		} else{
			if_north_east_kharif = append(if_north_east_kharif, 0)
		}



		
	}
}

for (i in 1:nrow(clean_data_rabi)){
	lbw_data <- clean_data_rabi[i,13+42]

	female_pct <- ((clean_data_rabi[i,13+31])/(1000+clean_data_rabi[i,13+31])) * 100

	gdp_data <- clean_data_rabi[i,70]
	beds_data <- clean_data_rabi[i,71]
	tap_data <- clean_data_rabi[i,72]

	index <- clean_data_rabi[i,69]
	category <- clean_data_rabi[i,63]

	child_marriage_data <- clean_data_rabi[i,73]
	nitrate_data <- clean_data_rabi[i,74]
	
	state <- clean_data_kharif[i,4]

	if (lbw_data<upper_bound_rabi && !is.na(gdp_data) && !is.na(beds_data) && !is.na(tap_data) &&
	  (gdp_data!=0) && (beds_data!=0) && (tap_data!=0)&& !is.na(child_marriage_data) 
	  && !is.na(nitrate_data)){

		v42_rabi = append(v42_rabi, lbw_data)

		v12_rabi = append(v12_rabi, clean_data_rabi[i,13+12])
		v15_rabi = append(v15_rabi, clean_data_rabi[i,13+15])
		v16_rabi = append(v16_rabi, clean_data_rabi[i,13+16])
		v25_rabi = append(v25_rabi, clean_data_rabi[i,13+25])
		v28_rabi = append(v28_rabi, clean_data_rabi[i,13+28])
		female_pct_rabi = append(female_pct_rabi, female_pct)
		gdp_rabi = append(gdp_rabi, gdp_data)

		beds_rabi = append(beds_rabi, beds_data)
		tap_rabi = append(tap_rabi, tap_data)

		child_marriage_rabi = append(child_marriage_rabi, child_marriage_data)
		nitrate_rabi = append(nitrate_rabi, nitrate_data)

		if (category=="Cash"){
		  cash_index_rabi = append(cash_index_rabi, index)
		  cereal_index_rabi = append(cereal_index_rabi, 0)
		} else if (category == "Cereal"){
		  cash_index_rabi = append(cash_index_rabi, 0)
		  cereal_index_rabi = append(cereal_index_rabi, index)
		} else{
		  cash_index_rabi = append(cash_index_rabi, 0)
		  cereal_index_rabi = append(cereal_index_rabi, 0)
		}

		if (state %in% north_zone){
			if_north_rabi = append(if_north_rabi, 1)
		} else{
			if_north_rabi = append(if_north_rabi, 0)
		}

		if (state %in% east_zone){
			if_east_rabi = append(if_east_rabi, 1)
		} else{
			if_east_rabi = append(if_east_rabi, 0)
		}

		if (state %in% west_zone){
			if_west_rabi = append(if_west_rabi, 1)
		} else{
			if_west_rabi = append(if_west_rabi, 0)
		}

		if (state %in% south_zone){
			if_south_rabi = append(if_south_rabi, 1)
		} else{
			if_south_rabi = append(if_south_rabi, 0)
		}

		if (state %in% central_zone){
			if_central_rabi = append(if_central_rabi, 1)
		} else{
			if_central_rabi = append(if_central_rabi, 0)
		}

		if (state %in% north_east_zone){
			if_north_east_rabi = append(if_north_east_rabi, 1)
		} else{
			if_north_east_rabi = append(if_north_east_rabi, 0)
		}

	}
}

#Making the linear model
model_kharif_north <- lm(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_north_kharif)
model_kharif_east <- lm(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_east_kharif)
model_kharif_west <- lm(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_west_kharif)
model_kharif_south <- lm(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_south_kharif)
model_kharif_central <- lm(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_central_kharif)
model_kharif_north_east <- lm(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_north_east_kharif)

model_rabi_north <- lm(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_north_rabi)
model_rabi_east <- lm(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_east_rabi)
model_rabi_west <- lm(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_west_rabi)
model_rabi_south <- lm(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_south_rabi)
model_rabi_central <- lm(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_central_rabi)
model_rabi_north_east <- lm(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_north_east_rabi)


print ("Models for Kharif:")
print ("N:")
print (length(v42_kharif))
summary(model_kharif_north)
summary(model_kharif_east)
summary(model_kharif_west)
summary(model_kharif_south)
summary(model_kharif_central)
summary(model_kharif_north_east)


print ("Model for Rabi:")
print ("N:")
print (length(v42_rabi))
summary(model_rabi_north)
summary(model_rabi_east)
summary(model_rabi_west)
summary(model_rabi_south)
summary(model_rabi_central)
summary(model_rabi_north_east)


#ANOVA TESTING
anova_kharif_north <- aov(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_north_kharif)
anova_kharif_east <- aov(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_east_kharif)
anova_kharif_west <- aov(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_west_kharif)
anova_kharif_south <- aov(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_south_kharif)
anova_kharif_central <- aov(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_central_kharif)
anova_kharif_north_east <- aov(v42_kharif~v12_kharif+v15_kharif+v16_kharif+v25_kharif+v28_kharif+female_pct_kharif+log(gdp_kharif) + log(beds_kharif) + tap_kharif + cash_index_kharif + cereal_index_kharif + child_marriage_kharif + nitrate_kharif + if_north_east_kharif)

anova_rabi_north <- aov(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_north_rabi)
anova_rabi_east <- aov(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_east_rabi)
anova_rabi_west <- aov(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_west_rabi)
anova_rabi_south <- aov(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_south_rabi)
anova_rabi_central <- aov(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_central_rabi)
anova_rabi_north_east <- aov(v42_rabi~v12_rabi+v15_rabi+v16_rabi+v25_rabi+v28_rabi+female_pct_rabi+log(gdp_rabi) + log(beds_rabi) + tap_rabi + cash_index_rabi + cereal_index_rabi + child_marriage_rabi + nitrate_rabi + if_north_east_rabi)


print ("Anovas for Kharif:")
print ("N:")
print (length(v42_kharif))
summary(anova_kharif_north)
summary(anova_kharif_east)
summary(anova_kharif_west)
summary(anova_kharif_south)
summary(anova_kharif_central)
summary(anova_kharif_north_east)


print ("Anova for Rabi:")
print ("N:")
print (length(v42_rabi))
summary(anova_rabi_north)
summary(anova_rabi_east)
summary(anova_rabi_west)
summary(anova_rabi_south)
summary(anova_rabi_central)
summary(anova_rabi_north_east)

print ("Description of variables used:")
print ("Explained variable: v42; Percentage of infant deaths due to Low Birth Weight (LBW) (to total reported infant deaths)")

print("Explanatory variables:")
print("v12: Percentage of women discharged in less than 48 hours of delivery (to total reported deliveries in public institutions)")
print("v15: Percentage of institutional deliveries (to total reported deliveries)")
print("v16: Percentage of safe deliveries (to total reported deliveries)")
print("v25: Percentage of reported live births (to reported births)")
print("v28: Percentage of newborns having weight less than 2.5 kg (to newborns weighed at birth)")
print("female_pct: Percentage of newborns who are female")
print("gdp: Gross Domestic Produce of the district")
print("beds: State-wise number of hospital beds")
print("tap: Percentage of households with tap water access")
print("Cash Index: Yield index of cash crops")
print("Cereal Index: Yield index of cereal crops")
print("Child Marriage: Number of reported child marriage cases")
print("Nitrate: Amount of nitrate in water")
