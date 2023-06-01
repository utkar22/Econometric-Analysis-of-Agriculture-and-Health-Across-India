#Question 2 Part A. In this part, we summarise each of the 6 dependant variables
#sepsis (v40)
#lbw (v42)
#pneumonia (v43)
#diarrhea (v44)
#fever (v45)
#measles (v46)
#by calculating the Mean, Median, Mode and Standard Deviation

#There is no inbuilt function to calculate Mode, so we have defined a function 
#of our own to find the mode.
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

#Setting the working directory to where we need it
setwd("C:\\Users\\Utkarsh\\Documents\\homework\\Econometrics\\Data Assignment 1")

#Opening the csv file
datafile <- read.csv("main9.csv")

#Calculating the means
mean_40 <- mean(datafile$v40, na.rm = TRUE, group)
mean_42 <- mean(datafile$v42, na.rm = TRUE)
mean_43 <- mean(datafile$v43, na.rm = TRUE)
mean_44 <- mean(datafile$v44, na.rm = TRUE)
mean_45 <- mean(datafile$v45, na.rm = TRUE)
mean_46 <- mean(datafile$v46, na.rm = TRUE)

#Calculating the medians
median_40 <- median(datafile$v40, na.rm = TRUE)
median_42 <- median(datafile$v42, na.rm = TRUE)
median_43 <- median(datafile$v43, na.rm = TRUE)
median_44 <- median(datafile$v44, na.rm = TRUE)
median_45 <- median(datafile$v45, na.rm = TRUE)
median_46 <- median(datafile$v46, na.rm = TRUE)

#Calculating the modes
mode_40 = Mode(datafile$v40)
mode_42 = Mode(datafile$v42)
mode_43 = Mode(datafile$v43)
mode_44 = Mode(datafile$v44)
mode_45 = Mode(datafile$v45)
mode_46 = Mode(datafile$v46)

#Calculating the standard deviations
sd_40 <- sd(datafile$v40, na.rm = TRUE)
sd_42 <- sd(datafile$v42, na.rm = TRUE)
sd_43 <- sd(datafile$v43, na.rm = TRUE)
sd_44 <- sd(datafile$v44, na.rm = TRUE)
sd_45 <- sd(datafile$v45, na.rm = TRUE)
sd_46 <- sd(datafile$v46, na.rm = TRUE)

#Creating a new data frame to print these values in tabular form
Variable <- c("sepsis","lbw","pneumonia","diarrhea","fever","measles")
Mean <- c(mean_40, mean_42, mean_43, mean_44, mean_45, mean_46)
Median <- c(median_40, median_42, median_43, median_44, median_45, median_46)
Mode <- c(mode_40, mode_42, mode_43, mode_44, mode_45, mode_46)
Standard_Deviation <- c(sd_40, sd_42, sd_43, sd_44, sd_45, sd_46)

new_df <- data.frame(Variable, Mean, Median, Mode, Standard_Deviation)
print(new_df)
