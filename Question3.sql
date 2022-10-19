#Question 3
#Mapping the housing units’ selling price per square foot in each neighborhood and their changes over time. (Are there rich neighborhoods and poor neighborhoods, relatively speaking? Does the fact rich or poor change over time?) 

--We use the formula: Volitality = standard deviation of sale price change * square root of time period to calculate how volatile each neighborhood is. 
--First we calculate the standard deviation of sale price change: 
WITH std_table AS (
SELECT DISTINCT NEIGHBORHOOD, ZIP_CODE, SQRT(VAR) AS STD
FROM
(SELECT NEIGHBORHOOD, ZIP_CODE,
      VARIANCE(PRICE_PER_SQUARE) OVER(PARTITION BY NEIGHBORHOOD) AS VAR
FROM (
      SELECT *,
      CAST(SALE_PRICE AS NUMERIC)/GROSS_SQUARE_FEET AS PRICE_PER_SQUARE
      FROM ba775-teamproject-b1.teamproject.processed_data
      )
ORDER BY NEIGHBORHOOD, var DESC)),

--Secondly, we look at how long each neighborhood's time period is in which sales have taken place. 
      time_period_table as (
SELECT NEIGHBORHOOD, ROUND(EXTRACT(DAY FROM DIFF_IN_DAYS)/365, 2) AS DIFF_IN_YEARS
FROM
(SELECT NEIGHBORHOOD,
CAST(
      CONCAT(EXTRACT(YEAR FROM MAX(SALE_DATE)),"-",EXTRACT(MONTH FROM MAX(SALE_DATE)),"-",
      EXTRACT(DAY FROM MAX(SALE_DATE))) AS DATE) - 
CAST(
      CONCAT(EXTRACT(YEAR FROM MIN(SALE_DATE)),"-",EXTRACT(MONTH FROM MIN(SALE_DATE)),"-",
      EXTRACT(DAY FROM MIN(SALE_DATE)))AS DATE) AS DIFF_IN_DAYS,  
FROM ba775-teamproject-b1.teamproject.processed_data 
GROUP BY NEIGHBORHOOD
ORDER BY NEIGHBORHOOD ASC)
      ) 

--Now we calculate the volitality 
SELECT * FROM(
SELECT s.NEIGHBORHOOD, ZIP_CODE, STD/SQRT(DIFF_IN_YEARS) AS volatility
FROM std_table AS s
JOIN time_period_table as t
ON s.NEIGHBORHOOD = t.NEIGHBORHOOD
ORDER BY volatility DESC) 
WHERE volatility IS NOT NULL
; -- no LIMIT since we are mapping here

#Note here that each neighborhood could have multiple zip codes, this is done in such way to more accurately map which areas in NYC have more volitalities in the sale prices of their houses. 
#Please refer to Question 3a for the names of the neighborhoods that have the highest volitality. 

