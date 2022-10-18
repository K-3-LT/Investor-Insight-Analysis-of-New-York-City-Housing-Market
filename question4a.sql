#Question 4a 
#Here we look at how buildings in appreciated/depreciated in their sale prices during the great financial crisis (+-4 years of 2008.) 
#With a time serie, we could map the areas that were most affected/least affected. 

WITH price_change_table AS(
SELECT *, avg_price_before - LAG(avg_price_before, 1) OVER(PARTITION BY NEIGHBORHOOD ORDER BY YEAR) AS price_change
FROM(
SELECT YEAR, NEIGHBORHOOD,
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET), 2) AS avg_price_before
FROM
(SELECT *, EXTRACT(year FROM SALE_DATE) AS YEAR       
FROM ba775-teamproject-b1.teamproject.processed_data)
GROUP BY YEAR, NEIGHBORHOOD
ORDER BY NEIGHBORHOOD ASC, YEAR DESC)) 

SELECT a.NEIGHBORHOOD, a.YEAR, ZIP_CODE, SUM(price_change) AS cum_price_change
FROM(
SELECT YEAR, NEIGHBORHOOD, avg_price_before, price_change
FROM price_change_table) AS a
LEFT JOIN  ba775-teamproject-b1.teamproject.processed_data AS b
ON a.NEIGHBORHOOD = b.NEIGHBORHOOD
WHERE CAST(YEAR AS NUMERIC) BETWEEN 2004 AND 2012
GROUP BY NEIGHBORHOOD, YEAR, ZIP_CODE
ORDER BY NEIGHBORHOOD, YEAR 
