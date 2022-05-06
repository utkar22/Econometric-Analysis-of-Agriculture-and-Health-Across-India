#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 2")

#Opening the csv file
datafile <- read.csv("main_final.csv")

clean_data = datafile[!duplicated(datafile$sdyid),]

full_lbw = clean_data$v42
mean_lbw = mean(full_lbw)
sd_lbw = sd(full_lbw)

upper_bound = mean_lbw + 3*sd_lbw

print(upper_bound)

year_data = c(0,0,0,0,0,0)

for (i in 1:nrow(clean_data)){
  year = clean_data[i,7]
  v42_data = clean_data[i,13+42]
  
  if (v42_data<upper_bound){
    year_data[year-2010] = year_data[year-2010] + v42_data
  }

}

print(year_data)
plot(year_data)
