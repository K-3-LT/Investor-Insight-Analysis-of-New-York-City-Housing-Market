# Option 2
# Checking the total sale price of residential buildings with the U.S. National Home Price Index (HPI) to see what is happening around the great financial crisis of 2008.
WITH a AS (
SELECT EXTRACT(YEAR FROM DATE) AS year, EXTRACT(MONTH FROM DATE) AS month, CSUSHPISA AS home_price_index  --retrieve the index related to the date
FROM `ba775-teamproject-b1.teamproject.home_price_index`
ORDER BY DATE
),
b AS (
SELECT EXTRACT(YEAR FROM SALE_DATE) AS year, EXTRACT(MONTH FROM SALE_DATE) AS month, SUM(SALE_PRICE) AS total_saleprice  -- sum the sale price for condo, house, home, dwellings and apartment related to the date
FROM `ba775-teamproject-b1.teamproject.nycdata`
WHERE BUILDING_CLASS_CATEGORY LIKE "%CONDO%"
OR BUILDING_CLASS_CATEGORY LIKE "%HOUSE%"
OR BUILDING_CLASS_CATEGORY LIKE "%HOME%"
OR BUILDING_CLASS_CATEGORY LIKE "%DWELLINGS%"
OR BUILDING_CLASS_CATEGORY LIKE "%APARTMENT%"
GROUP BY year, month
ORDER BY year, month
)

SELECT CONCAT(year, '-',month) AS year_month, home_price_index,   -- combine index and price table
        (total_saleprice/1000000000) as total_saleprice_in_billion
FROM(
SELECT a.year, a.month, home_price_index, total_saleprice
FROM a
JOIN b on a.year = b.year AND a.month = b.month
ORDER BY year, month) 
