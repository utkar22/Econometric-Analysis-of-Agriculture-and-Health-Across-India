#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 2")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Removing duplicate data
clean_data <- datafile[!duplicated(datafile$sdyid),]

yield_index <- clean_data$index
v42 <- clean_data$v42

#Getting the true model
true_model <- lm(v42~yield_index)
true_beta0 = summary(true_model)$coefficients[1,1]
true_beta1 = summary(true_model)$coefficients[2,1]

print(summary(true_model))


#To run Monte Carlo simulation, we randomly remove 20% of the data, and get the
#coefficients of correlation. We run this simulation in three sets, one time we
#run this simulation 100 times, another time 500 times, and another time 1000
#times. 
mc_beta0_100 <- c()
mc_beta1_100 <- c()

mc_beta0_500 <- c()
mc_beta1_500 <- c()

mc_beta0_1000 <- c()
mc_beta1_1000 <- c()

for (j in 1:1000){
  yield_index_mc_100 <- c()
  v42_mc_100 <- c()
  
  yield_index_mc_500 <- c()
  v42_mc_500 <- c()
  
  yield_index_mc_1000 <- c()
  v42_mc_1000 <- c()
  
  
  for (i in 1:nrow(clean_data)){
    rand_no_100 <- runif(1, min = 0, max = 100)
    rand_no_500 <- runif(1, min = 0, max = 100)
    rand_no_1000 <- runif(1, min = 0, max = 100)
    
    if (j<=100){
      if (rand_no_100>20){
        v42_mc_100 = append(v42_mc_100, clean_data[i,13+42])
        yield_index_mc_100 = append(yield_index_mc_100, clean_data[i,69])
      }
    }
    
    if (j<=500){
      if (rand_no_500>20){
        v42_mc_500 = append(v42_mc_500, clean_data[i,13+42])
        yield_index_mc_500 = append(yield_index_mc_500, clean_data[i,69])
      }
    }
    
    if (rand_no_1000>20){
      v42_mc_1000 = append(v42_mc_1000, clean_data[i,13+42])
      yield_index_mc_1000 = append(yield_index_mc_1000, clean_data[i,69])
    }
  
  }
  
  mc_model_100 <- lm(v42_mc_100~yield_index_mc_100)
  mc_model_500 <- lm(v42_mc_500~yield_index_mc_500)
  mc_model_1000 <- lm(v42_mc_1000~yield_index_mc_1000)
  
  mc_beta0_100 = append(mc_beta0_100, summary(mc_model_100)$coefficients[1,1])
  mc_beta1_100 = append(mc_beta1_100, summary(mc_model_100)$coefficients[2,1])
  
  mc_beta0_500 = append(mc_beta0_500, summary(mc_model_500)$coefficients[1,1])
  mc_beta1_500 = append(mc_beta1_500, summary(mc_model_500)$coefficients[2,1])
  
  mc_beta0_1000 = append(mc_beta0_1000, summary(mc_model_1000)$coefficients[1,1])
  mc_beta1_1000 = append(mc_beta1_1000, summary(mc_model_1000)$coefficients[2,1])
}

mean_mc_beta0_100 = mean(mc_beta0_100)
mean_mc_beta1_100 = mean(mc_beta1_100)
mean_mc_beta0_500 = mean(mc_beta0_500)
mean_mc_beta1_500 = mean(mc_beta1_500)
mean_mc_beta0_1000 = mean(mc_beta0_1000)
mean_mc_beta1_1000 = mean(mc_beta1_1000)

diff_beta0_100 = abs(mean_mc_beta0_100 - true_beta0)
diff_beta1_100 = abs(mean_mc_beta1_100 - true_beta1)
diff_beta0_500 = abs(mean_mc_beta0_500 - true_beta0)
diff_beta1_500 = abs(mean_mc_beta1_500 - true_beta1)
diff_beta0_1000 = abs(mean_mc_beta0_1000 - true_beta0)
diff_beta1_1000 = abs(mean_mc_beta1_1000 - true_beta1)

pct_beta0_100 = abs(diff_beta0_100 / true_beta0) * 100
pct_beta1_100 = abs(diff_beta1_100 / true_beta1) * 100
pct_beta0_500 = abs(diff_beta0_500 / true_beta0) * 100
pct_beta1_500 = abs(diff_beta1_500 / true_beta1) * 100
pct_beta0_1000 = abs(diff_beta0_1000 / true_beta0) * 100
pct_beta1_1000 = abs(diff_beta1_1000 / true_beta1) * 100

#We compare the means of the correlation of coefficients obtained in Monte Carlo
#simulations, with the true model

print("True beta 0: ")
print(true_beta0)

Beta_0 <- c("Mean B0","Diff from True B0","pct diff")
Monte_Carlo_B0_100 <- c(mean_mc_beta0_100, diff_beta0_100, pct_beta0_100)
Monte_Carlo_B0_500 <- c(mean_mc_beta0_500, diff_beta0_500, pct_beta0_500)
Monte_Carlo_B0_1000 <- c(mean_mc_beta0_1000, diff_beta0_1000, pct_beta0_1000)

Beta_0_df <- data.frame(Beta_0, Monte_Carlo_B0_100, Monte_Carlo_B0_500, Monte_Carlo_B0_1000)
print(Beta_0_df)


print("True beta 1: ")
print(true_beta1)

Beta_1 <- c("Mean B1","Diff from True B1","pct diff")
Monte_Carlo_B1_100 <- c(mean_mc_beta1_100, diff_beta1_100, pct_beta1_100)
Monte_Carlo_B1_500 <- c(mean_mc_beta1_500, diff_beta1_500, pct_beta1_500)
Monte_Carlo_B1_1000 <- c(mean_mc_beta1_1000, diff_beta1_1000, pct_beta1_1000)

Beta_1_df <- data.frame(Beta_1, Monte_Carlo_B1_100, Monte_Carlo_B1_500, Monte_Carlo_B1_1000)
print(Beta_1_df)

if (pct_beta0_100<5 && pct_beta1_100<5 && pct_beta0_500<5 && pct_beta1_500<5 && 
    pct_beta0_1000<5 && pct_beta1_1000<5){
  print("The difference between the True Model and Monte Carlo simulation is less than 5% for all coefficients")
  print("Hence, the difference is not statistically significant, and thus by Monte Carlo simulation,")
  print("The OLS estimates are consistent.")
}else{
  print("The difference between the True Model and Monte Carlo simulation is greater than 5% for at least one coefficient")
  print("Thus by Monte Carlo simulation, the OLD estimates are not consistent.")
}