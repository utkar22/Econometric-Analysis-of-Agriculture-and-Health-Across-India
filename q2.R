#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 2")

#Opening the csv file
datafile <- read.csv("main9.csv")

data_kharif <- subset(datafile, datafile$season == "Kharif")
data_rabi <- subset(datafile, datafile$season == "Rabi")

#Removing duplicate data
clean_data_kharif <- data_kharif[!duplicated(datafile$sdyid),]
clean_data_rabi <- data_rabi[!duplicated(datafile$sdyid),]


yield_index_kharif <- clean_data_kharif$index
v42_kharif <- clean_data_kharif$v42

yield_index_rabi <- clean_data_rabi$index
v42_rabi <- clean_data_rabi$v42

#Getting the true model
true_model_kharif <- lm(v42_kharif~yield_index_kharif)
true_beta0_kharif = summary(true_model_kharif)$coefficients[1,1]
true_beta1_kharif = summary(true_model_kharif)$coefficients[2,1]

true_model_rabi <- lm(v42_rabi~yield_index_rabi)
true_beta0_rabi = summary(true_model_rabi)$coefficients[1,1]
true_beta1_rabi = summary(true_model_rabi)$coefficients[2,1]

print(summary(true_model_kharif))
print(summary(true_model_rabi))


#To run Monte Carlo simulation, we randomly remove 20% of the data, and get the
#coefficients of correlation. We run this simulation in three sets, one time we
#run this simulation 100 times, another time 500 times, and another time 1000
#times. 
mc_beta0_kharif_100 <- c()
mc_beta1_kharif_100 <- c()

mc_beta0_kharif_500 <- c()
mc_beta1_kharif_500 <- c()

mc_beta0_kharif_1000 <- c()
mc_beta1_kharif_1000 <- c()


mc_beta0_rabi_100 <- c()
mc_beta1_rabi_100 <- c()

mc_beta0_rabi_500 <- c()
mc_beta1_rabi_500 <- c()

mc_beta0_rabi_1000 <- c()
mc_beta1_rabi_1000 <- c()

for (j in 1:1000){
  yield_index_mc_kharif_100 <- c()
  v42_mc_kharif_100 <- c()
  
  yield_index_mc_kharif_500 <- c()
  v42_mc_kharif_500 <- c()
  
  yield_index_mc_kharif_1000 <- c()
  v42_mc_kharif_1000 <- c()

  yield_index_mc_rabi_100 <- c()
  v42_mc_rabi_100 <- c()
  
  yield_index_mc_rabi_500 <- c()
  v42_mc_rabi_500 <- c()
  
  yield_index_mc_rabi_1000 <- c()
  v42_mc_rabi_1000 <- c()
  
  
  for (i in 1:nrow(clean_data_kharif)){
    rand_no_kharif_100 <- runif(1, min = 0, max = 100)
    rand_no_kharif_500 <- runif(1, min = 0, max = 100)
    rand_no_kharif_1000 <- runif(1, min = 0, max = 100)
    
    if (j<=100){
      if (rand_no_kharif_100>20){
        v42_mc_kharif_100 = append(v42_mc_kharif_100, clean_data_kharif[i,13+42])
        yield_index_mc_kharif_100 = append(yield_index_mc_kharif_100, clean_data_kharif[i,69])
      }
    }
    
    if (j<=500){
      if (rand_no_kharif_500>20){
        v42_mc_kharif_500 = append(v42_mc_kharif_500, clean_data_kharif[i,13+42])
        yield_index_mc_kharif_500 = append(yield_index_mc_kharif_500, clean_data_kharif[i,69])
      }
    }
    
    if (rand_no_kharif_1000>20){
      v42_mc_kharif_1000 = append(v42_mc_kharif_1000, clean_data_kharif[i,13+42])
      yield_index_mc_kharif_1000 = append(yield_index_mc_kharif_1000, clean_data_kharif[i,69])
    }
  
  }

  for (i in 1:nrow(clean_data_rabi)){
    rand_no_rabi_100 <- runif(1, min = 0, max = 100)
    rand_no_rabi_500 <- runif(1, min = 0, max = 100)
    rand_no_rabi_1000 <- runif(1, min = 0, max = 100)
    
    if (j<=100){
      if (rand_no_rabi_100>20){
        v42_mc_rabi_100 = append(v42_mc_rabi_100, clean_data_rabi[i,13+42])
        yield_index_mc_rabi_100 = append(yield_index_mc_rabi_100, clean_data_rabi[i,69])
      }
    }
    
    if (j<=500){
      if (rand_no_rabi_500>20){
        v42_mc_rabi_500 = append(v42_mc_rabi_500, clean_data_rabi[i,13+42])
        yield_index_mc_rabi_500 = append(yield_index_mc_rabi_500, clean_data_rabi[i,69])
      }
    }
    
    if (rand_no_rabi_1000>20){
      v42_mc_rabi_1000 = append(v42_mc_rabi_1000, clean_data_rabi[i,13+42])
      yield_index_mc_rabi_1000 = append(yield_index_mc_rabi_1000, clean_data_rabi[i,69])
    }
  
  }
  
  if (j<=100){
    mc_model_kharif_100 <- lm(v42_mc_kharif_100~yield_index_mc_kharif_100)
    mc_beta0_kharif_100 = append(mc_beta0_kharif_100, summary(mc_model_kharif_100)$coefficients[1,1])
    mc_beta1_kharif_100 = append(mc_beta1_kharif_100, summary(mc_model_kharif_100)$coefficients[2,1])

    mc_model_rabi_100 <- lm(v42_mc_rabi_100~yield_index_mc_rabi_100)
    mc_beta0_rabi_100 = append(mc_beta0_rabi_100, summary(mc_model_rabi_100)$coefficients[1,1])
    mc_beta1_rabi_100 = append(mc_beta1_rabi_100, summary(mc_model_rabi_100)$coefficients[2,1])
  }
  
  if (j<=500){
    mc_model_kharif_500 <- lm(v42_mc_kharif_500~yield_index_mc_kharif_500)
    mc_beta0_kharif_500 = append(mc_beta0_kharif_500, summary(mc_model_kharif_500)$coefficients[1,1])
    mc_beta1_kharif_500 = append(mc_beta1_kharif_500, summary(mc_model_kharif_500)$coefficients[2,1])

    mc_model_rabi_500 <- lm(v42_mc_rabi_500~yield_index_mc_rabi_500)
    mc_beta0_rabi_500 = append(mc_beta0_rabi_500, summary(mc_model_rabi_500)$coefficients[1,1])
    mc_beta1_rabi_500 = append(mc_beta1_rabi_500, summary(mc_model_rabi_500)$coefficients[2,1])
  }
    
  mc_model_kharif_1000 <- lm(v42_mc_kharif_1000~yield_index_mc_kharif_1000)
  mc_beta0_kharif_1000 = append(mc_beta0_kharif_1000, summary(mc_model_kharif_1000)$coefficients[1,1])
  mc_beta1_kharif_1000 = append(mc_beta1_kharif_1000, summary(mc_model_kharif_1000)$coefficients[2,1])

  mc_model_rabi_1000 <- lm(v42_mc_rabi_1000~yield_index_mc_rabi_1000)
  mc_beta0_rabi_1000 = append(mc_beta0_rabi_1000, summary(mc_model_rabi_1000)$coefficients[1,1])
  mc_beta1_rabi_1000 = append(mc_beta1_rabi_1000, summary(mc_model_rabi_1000)$coefficients[2,1])
}

mean_mc_beta0_kharif_100 = mean(mc_beta0_kharif_100)
mean_mc_beta1_kharif_100 = mean(mc_beta1_kharif_100)
mean_mc_beta0_kharif_500 = mean(mc_beta0_kharif_500)
mean_mc_beta1_kharif_500 = mean(mc_beta1_kharif_500)
mean_mc_beta0_kharif_1000 = mean(mc_beta0_kharif_1000)
mean_mc_beta1_kharif_1000 = mean(mc_beta1_kharif_1000)

diff_beta0_kharif_100 = abs(mean_mc_beta0_kharif_100 - true_beta0_kharif)
diff_beta1_kharif_100 = abs(mean_mc_beta1_kharif_100 - true_beta1_kharif)
diff_beta0_kharif_500 = abs(mean_mc_beta0_kharif_500 - true_beta0_kharif)
diff_beta1_kharif_500 = abs(mean_mc_beta1_kharif_500 - true_beta1_kharif)
diff_beta0_kharif_1000 = abs(mean_mc_beta0_kharif_1000 - true_beta0_kharif)
diff_beta1_kharif_1000 = abs(mean_mc_beta1_kharif_1000 - true_beta1_kharif)

pct_beta0_kharif_100 = abs(diff_beta0_kharif_100 / true_beta0_kharif) * 100
pct_beta1_kharif_100 = abs(diff_beta1_kharif_100 / true_beta1_kharif) * 100
pct_beta0_kharif_500 = abs(diff_beta0_kharif_500 / true_beta0_kharif) * 100
pct_beta1_kharif_500 = abs(diff_beta1_kharif_500 / true_beta1_kharif) * 100
pct_beta0_kharif_1000 = abs(diff_beta0_kharif_1000 / true_beta0_kharif) * 100
pct_beta1_kharif_1000 = abs(diff_beta1_kharif_1000 / true_beta1_kharif) * 100

#We compare the means of the correlation of coefficients obtained in Monte Carlo
#simulations, with the true model

print("True beta 0 (Kharif): ")
print(true_beta0_kharif)

Beta_0_kharif <- c("Mean B0","Diff from True B0","pct diff")
Monte_Carlo_B0_kharif_100 <- c(mean_mc_beta0_kharif_100, diff_beta0_kharif_100, pct_beta0_kharif_100)
Monte_Carlo_B0_kharif_500 <- c(mean_mc_beta0_kharif_500, diff_beta0_kharif_500, pct_beta0_kharif_500)
Monte_Carlo_B0_kharif_1000 <- c(mean_mc_beta0_kharif_1000, diff_beta0_kharif_1000, pct_beta0_kharif_1000)

Beta_0_df_kharif <- data.frame(Beta_0_kharif, Monte_Carlo_B0_kharif_100, Monte_Carlo_B0_kharif_500, Monte_Carlo_B0_kharif_1000)
print(Beta_0_df_kharif)


print("True beta 1 (Kharif): ")
print(true_beta1_kharif)

Beta_1_kharif <- c("Mean B1","Diff from True B1","pct diff")
Monte_Carlo_B1_kharif_100 <- c(mean_mc_beta1_kharif_100, diff_beta1_kharif_100, pct_beta1_kharif_100)
Monte_Carlo_B1_kharif_500 <- c(mean_mc_beta1_kharif_500, diff_beta1_kharif_500, pct_beta1_kharif_500)
Monte_Carlo_B1_kharif_1000 <- c(mean_mc_beta1_kharif_1000, diff_beta1_kharif_1000, pct_beta1_kharif_1000)

Beta_1_df_kharif <- data.frame(Beta_1_kharif, Monte_Carlo_B1_kharif_100, Monte_Carlo_B1_kharif_500, Monte_Carlo_B1_kharif_1000)
print(Beta_1_df_kharif)

mean_mc_beta0_rabi_100 = mean(mc_beta0_rabi_100)
mean_mc_beta1_rabi_100 = mean(mc_beta1_rabi_100)
mean_mc_beta0_rabi_500 = mean(mc_beta0_rabi_500)
mean_mc_beta1_rabi_500 = mean(mc_beta1_rabi_500)
mean_mc_beta0_rabi_1000 = mean(mc_beta0_rabi_1000)
mean_mc_beta1_rabi_1000 = mean(mc_beta1_rabi_1000)

diff_beta0_rabi_100 = abs(mean_mc_beta0_rabi_100 - true_beta0_rabi)
diff_beta1_rabi_100 = abs(mean_mc_beta1_rabi_100 - true_beta1_rabi)
diff_beta0_rabi_500 = abs(mean_mc_beta0_rabi_500 - true_beta0_rabi)
diff_beta1_rabi_500 = abs(mean_mc_beta1_rabi_500 - true_beta1_rabi)
diff_beta0_rabi_1000 = abs(mean_mc_beta0_rabi_1000 - true_beta0_rabi)
diff_beta1_rabi_1000 = abs(mean_mc_beta1_rabi_1000 - true_beta1_rabi)

pct_beta0_rabi_100 = abs(diff_beta0_rabi_100 / true_beta0_rabi) * 100
pct_beta1_rabi_100 = abs(diff_beta1_rabi_100 / true_beta1_rabi) * 100
pct_beta0_rabi_500 = abs(diff_beta0_rabi_500 / true_beta0_rabi) * 100
pct_beta1_rabi_500 = abs(diff_beta1_rabi_500 / true_beta1_rabi) * 100
pct_beta0_rabi_1000 = abs(diff_beta0_rabi_1000 / true_beta0_rabi) * 100
pct_beta1_rabi_1000 = abs(diff_beta1_rabi_1000 / true_beta1_rabi) * 100

#We compare the means of the correlation of coefficients obtained in Monte Carlo
#simulations, with the true model

print("True beta 0 (Rabi): ")
print(true_beta0_rabi)

Beta_0_rabi <- c("Mean B0","Diff from True B0","pct diff")
Monte_Carlo_B0_rabi_100 <- c(mean_mc_beta0_rabi_100, diff_beta0_rabi_100, pct_beta0_rabi_100)
Monte_Carlo_B0_rabi_500 <- c(mean_mc_beta0_rabi_500, diff_beta0_rabi_500, pct_beta0_rabi_500)
Monte_Carlo_B0_rabi_1000 <- c(mean_mc_beta0_rabi_1000, diff_beta0_rabi_1000, pct_beta0_rabi_1000)

Beta_0_df_rabi <- data.frame(Beta_0_rabi, Monte_Carlo_B0_rabi_100, Monte_Carlo_B0_rabi_500, Monte_Carlo_B0_rabi_1000)
print(Beta_0_df_rabi)


print("True beta 1 (Rabi): ")
print(true_beta1_rabi)

Beta_1_rabi <- c("Mean B1","Diff from True B1","pct diff")
Monte_Carlo_B1_rabi_100 <- c(mean_mc_beta1_rabi_100, diff_beta1_rabi_100, pct_beta1_rabi_100)
Monte_Carlo_B1_rabi_500 <- c(mean_mc_beta1_rabi_500, diff_beta1_rabi_500, pct_beta1_rabi_500)
Monte_Carlo_B1_rabi_1000 <- c(mean_mc_beta1_rabi_1000, diff_beta1_rabi_1000, pct_beta1_rabi_1000)

Beta_1_df_rabi <- data.frame(Beta_1_rabi, Monte_Carlo_B1_rabi_100, Monte_Carlo_B1_rabi_500, Monte_Carlo_B1_rabi_1000)
print(Beta_1_df_rabi)