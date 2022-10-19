#Question 1a is based on Question 1, out of the 49 categories of buildings, how many are condos, facilities, tax class (tax), hotel, and warehouse related? 

WITH building_price AS
(SELECT BUILDING_CLASS_CATEGORY, 
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS price_per_square
FROM ba775-teamproject-b1.teamproject.processed_data
GROUP BY BUILDING_CLASS_CATEGORY
ORDER BY price_per_square DESC
LIMIT 20)

SELECT ROUND((tot_number/20),4) AS PCT, BUILDING_CLASS_CATEGORY
FROM 
(SELECT BUILDING_CLASS_CATEGORY, COUNT(BUILDING_CLASS_CATEGORY) OVER() tot_number
FROM building_price
WHERE BUILDING_CLASS_CATEGORY LIKE "%CONDO%"
UNION ALL
SELECT BUILDING_CLASS_CATEGORY, COUNT(BUILDING_CLASS_CATEGORY) OVER() tot_number
FROM building_price
WHERE BUILDING_CLASS_CATEGORY LIKE "%FACILITIES%"
UNION ALL 
SELECT BUILDING_CLASS_CATEGORY, COUNT(BUILDING_CLASS_CATEGORY) OVER() tot_number
FROM building_price
WHERE BUILDING_CLASS_CATEGORY LIKE "%TAX%"
UNION ALL 
SELECT BUILDING_CLASS_CATEGORY, COUNT(BUILDING_CLASS_CATEGORY) OVER() tot_number
FROM building_price
WHERE BUILDING_CLASS_CATEGORY LIKE "%HOTEL%"
UNION ALL 
SELECT BUILDING_CLASS_CATEGORY, COUNT(BUILDING_CLASS_CATEGORY) OVER() tot_number
FROM building_price
WHERE BUILDING_CLASS_CATEGORY LIKE "%WAREHOUSE%"
)
ORDER BY PCT DESC
;

#Creating a new table for graphing purposes 

CREATE OR REPLACE TABLE ba775-teamproject-b1.teamproject.category_pct
(
 Category string, 
 Percentage float64
);
INSERT INTO ba775-teamproject-b1.teamproject.category_pct (Category, Percentage)
VALUES ('Condo', 0.5), ('Facility', 0.2), ('Tax Class', 0.1),
       ('Hotel', 0.05), ('Warehouse', 0.0);

