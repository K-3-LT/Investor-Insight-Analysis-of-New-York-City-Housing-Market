#Question 1a is based on Question 1, out of the 49 categories of buildings, how many are condos, facilities, tax class (tax), hotel, and warehouse related? 

WITH building_price AS
(SELECT BUILDING_CLASS_CATEGORY, 
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS price_per_square
FROM ba775-teamproject-b1.teamproject.processed_data
GROUP BY BUILDING_CLASS_CATEGORY
ORDER BY price_per_square DESC)

SELECT (tot_number/49) AS PCT, BUILDING_CLASS_CATEGORY
FROM 
(SELECT BUILDING_CLASS_CATEGORY, COUNT(BUILDING_CLASS_CATEGORY) OVER() tot_number  -- count the number of condo
FROM building_price
WHERE BUILDING_CLASS_CATEGORY LIKE "%CONDO%"
UNION ALL
SELECT BUILDING_CLASS_CATEGORY, COUNT(BUILDING_CLASS_CATEGORY) OVER() tot_number  -- count the number of facilities
FROM building_price
WHERE BUILDING_CLASS_CATEGORY LIKE "%FACILITIES%"
UNION ALL 
SELECT BUILDING_CLASS_CATEGORY, COUNT(BUILDING_CLASS_CATEGORY) OVER() tot_number  -- count the number of tax
FROM building_price
WHERE BUILDING_CLASS_CATEGORY LIKE "%TAX%"
UNION ALL 
SELECT BUILDING_CLASS_CATEGORY, COUNT(BUILDING_CLASS_CATEGORY) OVER() tot_number  -- count the number of hotel
FROM building_price
WHERE BUILDING_CLASS_CATEGORY LIKE "%HOTEL%"
UNION ALL 
SELECT BUILDING_CLASS_CATEGORY, COUNT(BUILDING_CLASS_CATEGORY) OVER() tot_number  -- count the number of warehouse
FROM building_price
WHERE BUILDING_CLASS_CATEGORY LIKE "%WAREHOUSE%"
)
ORDER BY PCT DESC
LIMIT 5;

#Creating a new table for graphing purposes 

CREATE OR REPLACE TABLE ba775-teamproject-b1.teamproject.category_pct
(
 Category string, 
 Percentage float64
);
INSERT INTO ba775-teamproject-b1.teamproject.category_pct (Category, Percentage)
VALUES ('Condo', 0.30612244897959184), ('Facility', 0.14285714285714285), ('Tax Class', 0.12244897959183673),
       ('Hotel', 0.061224489795918366), ('Warehouse', 0.020408163265306121);

