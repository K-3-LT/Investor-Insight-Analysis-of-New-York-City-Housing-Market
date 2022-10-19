#Question 2a

#Based on Question 2, here we look at specific building types with specific age that are sold at the highest price
#######EXCLUDED########
SELECT BUILDING_CLASS_CATEGORY, 
        (EXTRACT(YEAR FROM CURRENT_DATE()) - CAST(YEAR_BUILT AS INT)) AS building_age, 
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS price_per_square
FROM ba775-teamproject-b1.teamproject.processed_data 
GROUP BY BUILDING_CLASS_CATEGORY, building_age
ORDER BY price_per_square DESC
LIMIT 10;
#A graph can be drawn here

#From the first 10 rows above we can tell that buildings having a condo/facility/tax class/hotel/warehouse class are sold at a higher price, the question now begins as if the age of these buildings have a effect on them? 
#Condo
SELECT building_age, ROUND(AVG(price_per_square)) AS avg_psf
FROM 
(SELECT (EXTRACT(YEAR FROM CURRENT_DATE()) - CAST(YEAR_BUILT AS INT)) AS building_age, 
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS price_per_square
FROM ba775-teamproject-b1.teamproject.processed_data 
WHERE BUILDING_CLASS_CATEGORY LIKE '%CONDO%'
GROUP BY BUILDING_CLASS_CATEGORY, building_age
ORDER BY building_age ASC) 
GROUP BY building_age
ORDER BY building_age ASC;
#A graph can be drawn here. 

#Facility
SELECT building_age, ROUND(AVG(price_per_square)) AS avg_psf
FROM 
(SELECT (EXTRACT(YEAR FROM CURRENT_DATE()) - CAST(YEAR_BUILT AS INT)) AS building_age, 
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS price_per_square
FROM ba775-teamproject-b1.teamproject.processed_data 
WHERE BUILDING_CLASS_CATEGORY LIKE '%FACILITIES%'
GROUP BY BUILDING_CLASS_CATEGORY, building_age
ORDER BY building_age ASC) 
GROUP BY building_age
ORDER BY building_age ASC;
#A graph can be drawn here. 

#Tax Class
SELECT building_age, ROUND(AVG(price_per_square)) AS avg_psf
FROM 
(SELECT (EXTRACT(YEAR FROM CURRENT_DATE()) - CAST(YEAR_BUILT AS INT)) AS building_age, 
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS price_per_square
FROM ba775-teamproject-b1.teamproject.processed_data 
WHERE BUILDING_CLASS_CATEGORY LIKE '%TAX%'
GROUP BY BUILDING_CLASS_CATEGORY, building_age
ORDER BY building_age ASC) 
GROUP BY building_age
ORDER BY building_age ASC;
#A graph can be drawn here. 

#Hotel
SELECT building_age, ROUND(AVG(price_per_square)) AS avg_psf
FROM 
(SELECT (EXTRACT(YEAR FROM CURRENT_DATE()) - CAST(YEAR_BUILT AS INT)) AS building_age, 
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS price_per_square
FROM ba775-teamproject-b1.teamproject.processed_data 
WHERE BUILDING_CLASS_CATEGORY LIKE '%HOTEL%'
GROUP BY BUILDING_CLASS_CATEGORY, building_age
ORDER BY building_age ASC) 
GROUP BY building_age
ORDER BY building_age ASC;
#A graph can be drawn here. 

#Warehouse
SELECT building_age, ROUND(AVG(price_per_square)) AS avg_psf
FROM 
(SELECT (EXTRACT(YEAR FROM CURRENT_DATE()) - CAST(YEAR_BUILT AS INT)) AS building_age, 
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS price_per_square
FROM ba775-teamproject-b1.teamproject.processed_data 
WHERE BUILDING_CLASS_CATEGORY LIKE '%WAREHOUSE%'
GROUP BY BUILDING_CLASS_CATEGORY, building_age
ORDER BY building_age ASC) 
GROUP BY building_age
ORDER BY building_age ASC;
#A graph can be drawn here. 
