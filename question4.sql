#Question4
#Mapping the building class or neighborhood was most affected during the 2008 financial crisis.

WITH before_crash_table AS
(SELECT NEIGHBORHOOD, ZIP_CODE,
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS avg_price_before,       
FROM ba775-teamproject-b1.teamproject.processed_data
WHERE EXTRACT(year FROM SALE_DATE) = 2006
GROUP BY NEIGHBORHOOD, ZIP_CODE
HAVING avg_price_before > 0), 

        after_crash_table AS 
(SELECT NEIGHBORHOOD, 
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS avg_price_after,       
FROM ba775-teamproject-b1.teamproject.processed_data
WHERE EXTRACT(year FROM SALE_DATE) = 2008
GROUP BY NEIGHBORHOOD
HAVING avg_price_after > 0)

SELECT b.NEIGHBORHOOD, ZIP_CODE, b.avg_price_before, a.avg_price_after, 
(b.avg_price_before - a.avg_price_after) AS diff
FROM before_crash_table AS b
JOIN after_crash_table AS a
ON b.NEIGHBORHOOD = a.NEIGHBORHOOD
ORDER BY diff DESC
LIMIT 10; 
