library("ggplot2")
library("tidyverse")

#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 2")

#Opening the csv file
datafile <- read.csv("main9.csv")

#We subset the data file into two parts, one for Kharif and one for Rabi
data_kharif <- subset(datafile, datafile$season == "Kharif")
data_rabi <- subset(datafile, datafile$season == "Rabi")

lbw_full_kharif <- data_kharif$v42
mean_lbw_kharif = mean(lbw_full_kharif)
sd_lbw_kharif = sd(lbw_full_kharif)
upper_bound_kharif = mean_lbw_kharif + 3*sd_lbw_kharif

lbw_full_rabi <- data_rabi$v42
mean_lbw_rabi = mean(lbw_full_rabi)
sd_lbw_rabi = sd(lbw_full_rabi)
upper_bound_rabi = mean_lbw_rabi + 3*sd_lbw_rabi

v42_kharif <- c()
v42_rabi <- c()

index_kharif <- c()
index_rabi <- c()

for (i in 1:nrow(clean_data_kharif)){
	  index <- clean_data_kharif[i,69]
  	category <- clean_data_kharif[i,63]
  	lbw_data <- clean_data_kharif[i,13+42]

  	if (lbw_data<upper_bound_kharif){
  		v42_kharif = append(v42_kharif, lbw_data)
  		index_kharif = append(index_kharif, index)
  	}
}

for (i in 1:nrow(clean_data_rabi)){
	index <- clean_data_rabi[i,69]
  	category <- clean_data_rabi[i,63]
  	lbw_data <- clean_data_rabi[i,13+42]

  	if (lbw_data<upper_bound_rabi){
  		v42_rabi = append(v42_rabi, lbw_data)
  		index_rabi = append(index_rabi, index)
  	}
}


model_kharif <- lm(v42_kharif~index_kharif)
model_rabi <- lm(v42_rabi~index_rabi)

res_kharif <- residuals(model_kharif)
res_rabi <- residuals(model_rabi)

#Q1 Part B (i)

df_b_i_kharif<- data.frame(index_kharif,v42_kharif)
ggplot(df_b_i, aes(x=index_kharif, y=v42_kharif)) + geom_point() + stat_smooth(method = "lm", col="blue")

df_b_i_rabi<- data.frame(index_rabi,v42_rabi)
ggplot(df_b_i, aes(x=index_rabi, y=v42_rabi)) + geom_point() + stat_smooth(method = "lm", col="blue")

#Q1 Part B (ii)

df_b_ii_kharif <- data.frame(Yield_Index = index_kharif, Model_Residuals = res_kharif)
ggplot(df_b_ii_kharif, aes(x=Yield_Index, y = Model_Residuals)) + geom_point()

df_b_ii_rabi <- data.frame(Yield_Index = index_rabi, Model_Residuals = res_rabi)
ggplot(df_b_ii_rabi, aes(x=Yield_Index, y = Model_Residuals)) + geom_point()

#Q1 Part B (iii)

df_b_iii_kharif <- data.frame(Predicted_Value = predict(model_kharif), True_Value = v42_kharif)
ggplot(df_b_iii_kharif, aes(x = True_Value, y = Predicted_Value)) + geom_point() + geom_abline(intercept = 0, slope = 1, color = "green")

df_b_iii_rabi <- data.frame(Predicted_Value = predict(model_rabi), True_Value = v42_rabi)
ggplot(df_b_iii_rabi, aes(x = True_Value, y = Predicted_Value)) + geom_point() + geom_abline(intercept = 0, slope = 1, color = "green")

#Q1 Part C

sum(res_kharif)
sum(res_rabi)

df_c_kharif<- data.frame(res_kharif)
ggplot(df_c_kharif,aes(x=res_kharif)) + geom_histogram()

df_c_rabi<- data.frame(res_rabi)
ggplot(df_c_rabi,aes(x=res_rabi)) + geom_histogram()

#Q1 Part D

res_into_index_kharif = res_kharif * index_kharif
res_into_index_rabi = res_rabi * index_rabi

sum(res_into_index_kharif)
sum(res_into_index_rabi)

df_d_kharif<- data.frame(res_into_index_kharif)
ggplot(df_d_kharif,aes(x=res_into_index_kharif)) + geom_histogram()

df_d_rabi<- data.frame(res_into_index_rabi)
ggplot(df_d_rabi,aes(x=res_into_index_rabi)) + geom_histogram()