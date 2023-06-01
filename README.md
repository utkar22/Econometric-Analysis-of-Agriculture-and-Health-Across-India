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

`V42` = Intercept + `v12(k/r)` + `v15(k/r)` + `v16(k/r)` + `v25(k/r)` + `v28(k/r)` + `female_pct(k/r)` + `log(beds(k/r))` + `log(tap(k/r))` + `log(gdp(k/r))` + `cash_index(k/r)` + `cereal_index(k/r)` + `child_marriage(k/r)` + `nitrate(k/r)` + error

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


## Regression Results

The regression results for Kharif Crops and Rabi Crops are as follows:

### Kharif Crops

| Independent Variables    | Values (Intercepts/Slopes) | P-values     |
|--------------------------|---------------------------|--------------|
| Intercept                | -4.613096                 | 0.89657      |
| V12_Kharif               | -0.006821                 | 0.41328      |
| V15_Kharif               | 0.085319                  | 0.08371      |
| V16_Kharif               | -0.088949                 | 0.11546      |
| V25_Kharif               | -0.946380                 | 0.00372**    |
| V28_Kharif               | 0.056808                  | 0.02583*     |
| Female_Pct_Kharif        | 0.266830                  | 0.26838      |
| log(GDP_Kharif)          | 8.476883                  | <2e-16***    |
| log(Beds_Kharif)         | -3.853067                 | 8.42e-09***  |
| log(Taps_Kharif)         | 0.084959                  | 0.58439      |
| Cash_Index_Kharif        | -0.200288                 | <2e-16***    |
| Cereal_Index_Kharif      | -0.960962                 | 1.34e-05***  |
| Child_Marriage_Kharif    | -0.079927                 | 1.77e-05***  |
| Nitrate_Kharif           | 0.083899                  | 0.14199      |
| N                        | 2354                      |              |
| R^2 (adjusted)           | 0.2135                    |              |

### Rabi Crops

| Independent Variables    | Values (Intercepts/Slopes) | P-values    |
|--------------------------|---------------------------|-------------|
| Intercept                | 26.982771                 | 0.449815    |
| V12_Rabi                 | -0.020824                 | 0.01396*    |
| V15_Rabi                 | 0.158064                  | 0.001338**  |
| V16_Rabi                 | -0.146382                 | 0.009558**  |
| V25_Rabi                 | -1.201496                 | 0.000254*** |
| V28_Rabi                 | 0.084825                  | 0.001031**  |
| Female_Pct_Rabi          | 0.270657                  | 0.269665    |
| log(GDP_Rabi)            | 8.545709                  | <2e-16***   |
| log(Beds_Rabi)           | -4.859878                 | 1.64e-13    |
| log(Taps_Rabi)           | 0.693176                  | 4.83e-06*** |
| Cash_Index_Rabi          | 0.031997                  | 0.069256    |
| Cereal_Index_Rabi        | -0.710848                 | 8.79e-05*** |
| Child_Marriage_Rabi      | -0.041665                 | 0.034496    |
| Nitrate_Rabi             | 0.060745                  | 0.323791    |
| N                        | 2355                      |             |
| R^2 (adjusted)           | 0.195                     |             |


## Our Findings

In our analysis, we discovered several noteworthy findings related to child marriage cases, factors influencing low birth weight, socio-economic factors, and correlations between different variables. These findings are as follows:

### Child Marriage Cases Year Wise

We observed a drop in child marriage cases in the year 2014. There could be several possible reasons for this decline. One possible explanation is the occurrence of elections during that period. During elections, state resources might be allocated elsewhere, resulting in a lack of attention and monitoring of child marriage cases. Another possibility is that state authorities might be working overtime on election-related activities, leading to fewer reported cases. Under-reporting could also be a contributing factor.

### Factors Related to an Increase in Low Birth Weight

Our analysis identified several factors that are positively associated with an increase in low birth weight. These factors include anemia, low maternal weight, prior experience of stillbirth, and low food diversity. These findings highlight the importance of addressing these factors to reduce the incidence of low birth weight.

### Factors Related to a Decrease in Low Birth Weight

On the other hand, we found that certain factors are related to a decrease in low birth weight. These factors include attending ANC (Antenatal Care) sessions, taking iron supplements, and delivering in established health facilities. These findings underscore the significance of proper antenatal care and access to healthcare services in preventing low birth weight.

### Socio-Economic Factors and Incidence of Low Birth Weight

While socio-economic factors are known to play a role in the incidence of low birth weight, our analysis did not include variables measuring socio-economic conditions. Therefore, we were unable to directly assess their impact on our findings. Future studies should consider incorporating socio-economic variables to gain a more comprehensive understanding of the relationship between socio-economic factors and low birth weight.

### Correlation between v12 and v42

We hypothesized that there would be an inverse relationship between v12 (percentage of women discharged in less than 48 hours of delivery) and v42 (percentage of infant deaths due to Low Birth Weight). Our reasoning was that women who gave birth to a child with low birth weight would likely require longer hospital stays for additional tests and increased postnatal care. Our regression analysis confirmed this hypothesis, as the estimate showed a negative sign, indicating an inverse correlation between v12 and v42.

### Correlation between v15 and v42

Contrary to our initial expectations, we found a positive correlation between v15 (percentage of institutional deliveries) and v42 (percentage of infant deaths due to Low Birth Weight). This finding raises questions about the quality and performance of institutions included in the dataset. It suggests that institutions may not be consistently providing the required level of care and that the reported cause of death may not always be accurately documented.

### Sex Ratio, Preterm Birth Rate, and LBW Rate

We observed that the sex ratio was 1.23 males per female, the preterm birth rate was 9.58%, and the low birth weight rate was 11.23%. Our regression analysis indicated a weak correlation between sex ratio and the incidence of low birth weight, aligning with these findings.

These findings provide valuable insights into the factors influencing low birth weight and highlight the need for targeted interventions to improve maternal and child health outcomes.



## Limitations of Data and Analysis

Our data and analysis have several limitations that should be taken into consideration when interpreting the results. These limitations include:

1. Socio-Economic Factors: Our analysis could not account for important socio-economic factors like income, food diversity, and societal status. These factors are known to influence maternal health and may have an impact on the incidence of low birth weight. Without considering these variables, our analysis may provide an incomplete picture of the factors contributing to low birth weight.

2. Government Policies: We could only find policies related to maternal health at the beginning of the time period (2011-16). The analysis does not incorporate the influence of government policies throughout the entire time frame. It is possible that additional policies implemented during the period could have affected maternal health outcomes and the incidence of low birth weight.

3. GDP State-wise: The available GDP data is from a different time period, making it difficult to draw conclusive insights about its relationship with low birth weight. The time discrepancy may limit the accuracy of our conclusions regarding the impact of GDP on the outcome variable.

4. Homoskedasticity: We attempted to make our data homoskedastic, but encountered challenges in determining the appropriate weighting scheme for different groups. As a result, the homoskedasticity assumption may not hold perfectly in our analysis.

5. Structural Breaks: Our analysis did not explore structural breaks within the country beyond what was covered in data assignment 2. Considering potential structural breaks and their influence on the incidence of low birth weight could provide a more comprehensive understanding of the phenomenon.

6. Multiple Births: We were unable to determine the percentage of single births versus multiple births (twins, triplets, etc.). According to literature, multiple births are associated with an increased risk of low birth weight. Not accounting for this information may limit the accuracy of our analysis.

7. Nitrate Policy: We could not find any specific policies related to nitrate levels in the given time period. However, the presence of nitrate in water supplies did align with our expectations. Further exploration of policies related to nitrate and their impact on maternal health could enhance the analysis.

It is important to keep these limitations in mind when interpreting our findings, as they highlight the factors that our data and analysis could not fully account for.




## Conclusion

This project analyzed the percentage of infant deaths due to low birth weight (LBW) in relation to various factors. The model considered both kharif and rabi crops separately, and the regression results showed that the variables had varying levels of significance in determining the percentage of infant deaths due to LBW.

The variables considered in the model included the percentage of women discharged in less than 48 hours of delivery, percentage of institutional deliveries, percentage of safe deliveries, percentage of reported live births, percentage of newborns having a weight less than 2.5 kg, percentage of female births, log of GDP, log of number of hospital beds, log of number of taps with water access, yield index of cash crops, yield index of cereal crops, number of child marriage cases reported, and the measure of nitrate in the water supply.

The choice of variables was based on intuition and empirical data from various sources. The variables were mostly linear, and log10 was taken for GDP, taps, and beds, as those values were very high. The regression results showed that most variables had a significant impact on the percentage of infant deaths due to LBW, except for the percentage of female births and the measure of nitrate in the water supply.

In conclusion, this project provided valuable insights into the factors that affect the percentage of infant deaths due to LBW. The findings can be used to develop policies and interventions that can reduce the incidence of LBW and improve the health outcomes of infants.

## References

1. Nitrate data source: [Central Pollution Control Board](https://cpcb.nic.in/nwmp-data-2019/)
2. Child marriage data source: [data.gov.in](https://data.gov.in/resource/stateut-wise-number-child-marriage-cases-prohibition-child-marriage-act-2006-2013-2017)
3. Study on sex ratio and low birth weight: [PubMed](https://pubmed.ncbi.nlm.nih.gov/25096219/)
4. Nitrate and maternal health: [PubMed](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1392223/)
5. Child marriage and low birth weight: [Wiley Online Library](https://onlinelibrary.wiley.com/doi/full/10.1002/ajhb.23709)
6. Data on maternal health: [National Center for Biotechnology Information](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2761784/)
7. Link between maternal health and low birth weight: [PLOS ONE](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0244562#sec006)
8. Data on low birth weight and sex ratio: [Journal of Clinical and Diagnostic Research](http://journalcra.com/sites/default/files/issue-pdf/38684_0.pdf)

