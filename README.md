# Introduction

This project presents an econometric analysis of various health indicators on diseases across all districts in India, performed using R programming language. The analysis was carried out as part of the Econometrics-1 course offered during the fourth semester, in March and April of 2022. The aim of this analysis was to examine the relationship between different health indicators and diseases across various districts in India, using the cleaned and preprocessed dataset obtained by appending external data for GDP, hospital beds, and tap water availability to the main dataset. The findings of this analysis are expected to provide insights into the state of healthcare and the impact of various health indicators on diseases in different districts of India, which may inform policy decisions aimed at improving healthcare outcomes.

Members:

Utkarsh Arora

Keshav Rajput

Krishnasai Addala

Samarth Raina

Sejal Kardam

## Dataset
The dataset used in this project contains information on agricultural yield data alongside different health indicators for different districts across six years (2011-2016) in India. The dataset was provided to us by the course instructor in the form of a CSV file.

## Data Preprocessing
As part of the data preprocessing step, we created datasets for GDP, hospital beds, and tap water using data obtained from the internet. We then added this data to the appended columns in the larger dataset.

In addition, we found data on child marriage rates across various states of India and the content of nitate in the water supply. We included these additional datasets in our analysis.

To ensure that our analysis was robust, we performed data cleaning. Our analysis in this project depends on the dependent variables v40, v42, v43, v44, v45, and v46, and the explanatory variables index, GDP, hospital beds, and tap water. For some states and districts, values for GDP and tap water were not given (e.g., Ladakh). For the years 2017-2019, we did not have data for the dependent variables.

In any of the rows where data for any of the 10 variables (dependent and independent) was missing, we removed that row. This was to ensure that our vectors when conducting analysis did not have NULL values and were of equal sizes. In other variables where we had missing data, we replaced the missing values with NA.

The input dataset used for our analysis was named main.csv, while the appended and cleaned dataset was named main9.csv.


## Preliminary Analysis
In this section, we provide an overview of the preliminary analysis conducted on the dataset. The analysis was divided into three parts, and involved exploratory data analysis, regression modelling, and correlation analysis.

### Exploratory Data Analysis
The first part of the analysis involved exploring the distribution of the variables in the dataset. We created histograms for each variable to understand their distribution and range. We also conducted a simple statistical summary to get an idea of the mean, standard deviation, and other descriptive statistics for each variable.

### Regression Modelling
The second part of the analysis involved experimenting with different regression models to identify the best predictors of the health indicators. We used a variety of explanatory variables, including yield index of different crop categories, level-level vs level-log models, and more. We noticed that yield indexes of some different crop categories have an opposing effect on the health indicator, which is missed out when we include the yield index for all six crop categories together. This highlights the importance of precision over generality in our analysis.

### Correlation Analysis
In the third part of the analysis, we conducted a correlation analysis between yield growth and health indicators across different crop categories. We found that the relationship between yield growth and health indicators is not similar across crop categories. For example, sepsis has a negative correlation with yield growth across all crop categories, whereas lbw has a negative correlation with yield growth rate of cash crops, but a positive correlation with yield growth rates across other crop categories. Pneumonia, on the other hand, has a positive correlation with yield growth rate of cash, but a negative correlation with yield growth rates across other crop categories. We also observed that the theoretical relation between the coefficient of correlation and the goodness of fit holds in the given data.

Overall, the preliminary analysis provides a good starting point for our analysis of the relationship between agriculture and health indicators. By exploring the distribution of variables, experimenting with regression models, and conducting a correlation analysis, we have gained valuable insights into the dataset, which will inform our subsequent analysis.

### Monte Carlo Simulations

As part of our preliminary analysis, we conducted Monte Carlo simulations to assess the robustness of our results. The goal of the simulations was to understand the variability and stability of the estimated coefficients in our regression model when a certain percentage of data is randomly dropped. We performed the simulations by randomly dropping 20% of the data from our main dataset. We repeated this process multiple times to observe the consistency of the estimated coefficients. We conducted the simulations for three different iterations: 100 times, 500 times, and 1000 times. By observing the stability and distribution of the estimated coefficients across these iterations, we gained insights into the reliability of our regression model and the potential impact of missing data.

The coefficients for most variables showed relatively small variations across different iterations of the simulations. This indicates that our regression model is robust and produces consistent results even with a random drop of 20% of the data.

## Model Description
The model equation is as follows:

`V42` = Intercept + `v12(k/r)` + `v15(k/r)` + `v16(k/r)` + `v25(k/r)` + `v28(k/r)` + `female_pct(k/r)` + `log(beds(k/r))` + `log(tap(k/r))` + `log(gdp(k/r))` + `cash_index(k/r)` + `cereal_index(k/r)` + `child_marriage(k/r)` + `nitrate(k/r)` + `error`

Here, (k/r) denotes that the variable is different for rabi and kharif. The model uses an intercept and considers various independent variables to predict the dependent variable V42. The model also takes into account the error term to account for any variance that cannot be explained by the included independent variables.


## Variables

The following variables were used in the model:

### Health and Birth Indicators

- `v42`: Percentage of infant deaths due to Low Birth Weight (LBW) (to total reported infant deaths)
- `v12`: Percentage of women discharged in less than 48 hours of delivery (to total reported deliveries in public institutions)
- `v15`: Percentage of institutional deliveries (to total reported deliveries)
- `v16`: Percentage of safe deliveries (to total reported deliveries)
- `v25`: Percentage of reported live births (to reported births)
- `v28`: Percentage of newborns having weight less than 2.5 kg (to newborns weighed at birth)
- `female_pct`: Percentage of female births to total births
- `child_marriage`: Number of child marriage cases reported state-wise at a particular time.


### Economic Indicators

- `log10(gdp)`: Log of GDP of states
- `log10(beds)`: Log of number of hospital beds by states
- `log10(taps)`: Log of number of taps with water access district wise

### Agricultural Indicators
- `cash_index`: Yield Index of the cash crops grown at a particular district at a particular time
- `cereal_index`: Yield Index of the cereal crops grown in a particular district at a particular time

### Environmental Indicators
- `nitrate`: Measure of quality of water, indicates the presence of nitrate in water supply in standard units.

### Choice of Variables

The variables were chosen based on intuition and empirical data found on the internet. For example, child marriage was chosen as it increases the risk of premature birth which is the single biggest cause of low birth weight. Nitrate was included to consider environmental factors that could possibly affect the mother's health. The variables `v12`, `v15`, `v16`, `v25`, and `v28` were chosen based on intuitive reasoning. The cereal index was included as it can affect the nutrition of the mother, which is likely to affect the health of the child.

### Function of Variables

Most of the variables are linear, but `log10(gdp)`, `log10(beds)`, and `log10(taps)` were taken as their values are very large. Also, `log(x)` is a monotonic function so it will not affect the overall trend, i.e., slope sign. The log values for `gdp`, `beds`, and `taps` were taken to reduce the high magnitudes of values within the sample to comparable values.



## Conclusion

This project analyzed the percentage of infant deaths due to low birth weight (LBW) in relation to various factors. The model considered both kharif and rabi crops separately, and the regression results showed that the variables had varying levels of significance in determining the percentage of infant deaths due to LBW.

The variables considered in the model included the percentage of women discharged in less than 48 hours of delivery, percentage of institutional deliveries, percentage of safe deliveries, percentage of reported live births, percentage of newborns having a weight less than 2.5 kg, percentage of female births, log of GDP, log of number of hospital beds, log of number of taps with water access, yield index of cash crops, yield index of cereal crops, number of child marriage cases reported, and the measure of nitrate in the water supply.

The choice of variables was based on intuition and empirical data from various sources. The variables were mostly linear, and log10 was taken for GDP, taps, and beds, as those values were very high. The regression results showed that most variables had a significant impact on the percentage of infant deaths due to LBW, except for the percentage of female births and the measure of nitrate in the water supply.

In conclusion, this project provided valuable insights into the factors that affect the percentage of infant deaths due to LBW. The findings can be used to develop policies and interventions that can reduce the incidence of LBW and improve the health outcomes of infants.
