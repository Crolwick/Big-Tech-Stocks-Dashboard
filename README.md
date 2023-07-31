# Big-Tech-Stocks-Dashboard

## Data Used
Data - Big Tech Stocks Data from years 2010 to 2022 from Kaggle (Amazon, Apple, Google (Alphabet), Microsoft) -> https://www.kaggle.com/datasets/evangower/big-tech-stock-prices
Data Cleaning & Analysis - MySQL Workbench
Data Visualization - PowerBI

## Questions
1) What is the maximum opening price for a company's stocks each year?
2) What is the volume of stock recorded by year for each company from 2010-2022?
3) What is the maximum volume each company has made throughout all years, and what month was it?
4) In 2017,  what is the relationship between volume and opening prices for all companies?
5) What is the average volatility for each company?
6) What is the drawdown price for each company between the years 2019-2021?
7) What is the drawdown price for each company between the years 2021-2022?
8) What is the Compound Annual Growth Rate for each company, or rather the growth of a company's investments over some time (2010-2022)?

## Summary of Findings
* The highest opening price for Amazon in 2021 was a value of $187.20 compared to Google in the same year with $149.98.
* The highest opening price in the year 2019 for Apple was $72.78 and $159.45 for Microsoft.
* Volume of stock by year seems to be in a decrease starting from 2010 to 2022 for all companies except for Amazon which is more generally the constant.
* Most companies have achieved their highest volumes between the years 2010-2011 with Apple achieving the most overall.
* Based on the data, Amazon and Google seem to have generally a constant relationship between the opening prices and volume of their stocks with a spike at some point in 2017
* Apple starts very high in the relationship between opening and volume but gets a dry phase before being at a normal constant the rest of the way, and Microsoft is the reverse relationship of Apple.
* Average volatility all seem to be on a low, but Microsoft leading would mean they have a higher risk of stock prices fluctuating than the others.
* The years 2019-2021 represent the COVID-19 years and show to have a huge drawdown percentage for all companies with Amazon with the least amount of drawdown
* The years 2021-2022 represent the post-COVID-19 year and show that only Apple and Microsoft still have a huge drawdown percentage compared to Google and Amazon which have improved quite a bit.
* Apple and Amazon seem to have the highest CAGR percentage which means they had the fastest-growing investments over this time period.

## Limitations and Concerns
* Some records were difficult to show like the relationship between volume and opening price. I decided on the year 2017 because it was the middle year between 2010 and 2022 that seemed relevant. Other years could show a significantly different result and could change the prediction significantly.
* Some queries did not have enough space to show every entry, and therefore, I had to change part of my analysis.
