#Question 3a 
#The codes here are roughly same with Question3, but in this part we are trying to find the neighborhoods with the highest volitalities (without including zip codes)

WITH std_table AS (
SELECT DISTINCT NEIGHBORHOOD, SQRT(VAR) AS STD
FROM
(SELECT NEIGHBORHOOD,
      VARIANCE(PRICE_PER_SQUARE) OVER(PARTITION BY NEIGHBORHOOD) AS VAR
FROM (
      SELECT *,
      CAST(SALE_PRICE AS NUMERIC)/GROSS_SQUARE_FEET AS PRICE_PER_SQUARE
      FROM ba775-teamproject-b1.teamproject.processed_data
      )
ORDER BY NEIGHBORHOOD, var DESC)),

#Secondly, we look at how long each neighborhood's time period is in which sales have taken place. 
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

#Now we calculate the volitality 
SELECT * FROM(
SELECT s.NEIGHBORHOOD, STD/SQRT(DIFF_IN_YEARS) AS volitality
FROM std_table AS s
JOIN time_period_table as t
ON s.NEIGHBORHOOD = t.NEIGHBORHOOD
ORDER BY volitality DESC) 
WHERE volitality IS NOT NULL
LIMIT 10; -- LIMIT since we are creating a bar plot here
