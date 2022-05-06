#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 2")

#Opening the csv file
datafile <- read.csv("main_final.csv")

clean_data = datafile[!duplicated(datafile$sdyid),]

v42_before <- c()
v42_after <- c()

child_marriage_before <- c()
child_marriage_after <- c()

nitrate_before <- c()
nitrate_after <- c()

for (i in 1:nrow(clean_data)){
  year = clean_data[i,7]
  v42_data = clean_data[i,13+42]
  child_marriage_data = clean_data[i,73]
  nitrate_data = clean_data[i,74]
  
  if (year<2014){
    v42_before = append(v42_before, v42_data)
    child_marriage_before = append(child_marriage_before, child_marriage_data)
    nitrate_before = append(nitrate_before, nitrate_data)
  } else{
    v42_after = append(v42_after, v42_data)
    child_marriage_after = append(child_marriage_after, child_marriage_data)
    nitrate_after = append(nitrate_after, nitrate_data)
  }
}

cm_before = lm(v42_before ~ child_marriage_before)
cm_after = lm(v42_after ~ child_marriage_after)

n_before = lm(v42_before ~ nitrate_before)
n_after = lm(v42_after ~ nitrate_after)

summary(cm_before)
summary(cm_after)
summary(n_before)
summary(n_after)
