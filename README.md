# Introduction

This project presents an econometric analysis of various health indicators on diseases across all districts in India, performed using R programming language. The analysis was carried out as part of the Econometrics-1 course offered during the fourth semester, in March and April of 2022. The aim of this analysis was to examine the relationship between different health indicators and diseases across various districts in India, using the cleaned and preprocessed dataset obtained by appending external data for GDP, hospital beds, and tap water availability to the main dataset. The findings of this analysis are expected to provide insights into the state of healthcare and the impact of various health indicators on diseases in different districts of India, which may inform policy decisions aimed at improving healthcare outcomes.

Members:
Utkarsh Arora

Keshav Rajput

Krishnasai Addala

Samarth Raina

Sejal Kardam

# Dataset
The dataset used in this project contains information on agricultural yield data alongside different health indicators for different districts across six years (2011-2016) in India. The dataset was provided to us by the course instructor in the form of a CSV file.

# Data Preprocessing
As part of the data preprocessing step, we created datasets for GDP, hospital beds, and tap water using data obtained from the internet. We then added this data to the appended columns in the larger dataset.

In addition, we found data on child marriage rates across various states of India and the content of nitate in the water supply. We included these additional datasets in our analysis.

To ensure that our analysis was robust, we performed data cleaning. Our analysis in this project depends on the dependent variables v40, v42, v43, v44, v45, and v46, and the explanatory variables index, GDP, hospital beds, and tap water. For some states and districts, values for GDP and tap water were not given (e.g., Ladakh). For the years 2017-2019, we did not have data for the dependent variables.

In any of the rows where data for any of the 10 variables (dependent and independent) was missing, we removed that row. This was to ensure that our vectors when conducting analysis did not have NULL values and were of equal sizes. In other variables where we had missing data, we replaced the missing values with NA.

The input dataset used for our analysis was named main.csv, while the appended and cleaned dataset was named main9.csv.


# Preliminary Analysis
In this section, we provide an overview of the preliminary analysis conducted on the dataset. The analysis was divided into three parts, and involved exploratory data analysis, regression modelling, and correlation analysis.

## Exploratory Data Analysis
The first part of the analysis involved exploring the distribution of the variables in the dataset. We created histograms for each variable to understand their distribution and range. We also conducted a simple statistical summary to get an idea of the mean, standard deviation, and other descriptive statistics for each variable.

## Regression Modelling
The second part of the analysis involved experimenting with different regression models to identify the best predictors of the health indicators. We used a variety of explanatory variables, including yield index of different crop categories, level-level vs level-log models, and more. We noticed that yield indexes of some different crop categories have an opposing effect on the health indicator, which is missed out when we include the yield index for all six crop categories together. This highlights the importance of precision over generality in our analysis.

## Correlation Analysis
In the third part of the analysis, we conducted a correlation analysis between yield growth and health indicators across different crop categories. We found that the relationship between yield growth and health indicators is not similar across crop categories. For example, sepsis has a negative correlation with yield growth across all crop categories, whereas lbw has a negative correlation with yield growth rate of cash crops, but a positive correlation with yield growth rates across other crop categories. Pneumonia, on the other hand, has a positive correlation with yield growth rate of cash, but a negative correlation with yield growth rates across other crop categories. We also observed that the theoretical relation between the coefficient of correlation and the goodness of fit holds in the given data.

Overall, the preliminary analysis provides a good starting point for our analysis of the relationship between agriculture and health indicators. By exploring the distribution of variables, experimenting with regression models, and conducting a correlation analysis, we have gained valuable insights into the dataset, which will inform our subsequent analysis.


# Conclusion

Conclusion:

This project analyzed the percentage of infant deaths due to low birth weight (LBW) in relation to various factors. The model considered both kharif and rabi crops separately, and the regression results showed that the variables had varying levels of significance in determining the percentage of infant deaths due to LBW.

The variables considered in the model included the percentage of women discharged in less than 48 hours of delivery, percentage of institutional deliveries, percentage of safe deliveries, percentage of reported live births, percentage of newborns having a weight less than 2.5 kg, percentage of female births, log of GDP, log of number of hospital beds, log of number of taps with water access, yield index of cash crops, yield index of cereal crops, number of child marriage cases reported, and the measure of nitrate in the water supply.

The choice of variables was based on intuition and empirical data from various sources. The variables were mostly linear, and log10 was taken for GDP, taps, and beds, as those values were very high. The regression results showed that most variables had a significant impact on the percentage of infant deaths due to LBW, except for the percentage of female births and the measure of nitrate in the water supply.

In conclusion, this project provided valuable insights into the factors that affect the percentage of infant deaths due to LBW. The findings can be used to develop policies and interventions that can reduce the incidence of LBW and improve the health outcomes of infants.
