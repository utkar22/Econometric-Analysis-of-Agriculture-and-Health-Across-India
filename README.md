#Introduction

This project presents an econometric analysis of various health indicators on diseases across all districts in India, performed using R programming language. The analysis was carried out as part of the Econometrics-1 course offered during the fourth semester, in March and April of 2022. The aim of this analysis was to examine the relationship between different health indicators and diseases across various districts in India, using the cleaned and preprocessed dataset obtained by appending external data for GDP, hospital beds, and tap water availability to the main dataset. The findings of this analysis are expected to provide insights into the state of healthcare and the impact of various health indicators on diseases in different districts of India, which may inform policy decisions aimed at improving healthcare outcomes.

# Dataset
The dataset used in this project contains information on agricultural yield data alongside different health indicators for different districts across six years (2011-2016) in India. The dataset was provided to us by the course instructor in the form of a CSV file.

# Data Preprocessing
As part of the data preprocessing step, we created datasets for GDP, hospital beds, and tap water using data obtained from the internet. We then added this data to the appended columns in the larger dataset.

In addition, we found data on child marriage rates across various states of India and the content of nitate in the water supply. We included these additional datasets in our analysis.

To ensure that our analysis was robust, we performed data cleaning. Our analysis in this project depends on the dependent variables v40, v42, v43, v44, v45, and v46, and the explanatory variables index, GDP, hospital beds, and tap water. For some states and districts, values for GDP and tap water were not given (e.g., Ladakh). For the years 2017-2019, we did not have data for the dependent variables.

In any of the rows where data for any of the 10 variables (dependent and independent) was missing, we removed that row. This was to ensure that our vectors when conducting analysis did not have NULL values and were of equal sizes. In other variables where we had missing data, we replaced the missing values with NA.

The input dataset used for our analysis was named main.csv, while the appended and cleaned dataset was named main9.csv.
