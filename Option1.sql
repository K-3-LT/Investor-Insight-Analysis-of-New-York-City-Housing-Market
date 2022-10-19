#Option 1
--Exhibit how many house built in every year
WITH a AS(
SELECT CAST(YEAR_BUILT AS INT) AS YEAR, COUNT(ADDRESS) AS built_of_house
FROM `ba775-teamproject-b1.teamproject.processed_data`
WHERE BUILDING_CLASS_CATEGORY LIKE "%CONDO%"
OR BUILDING_CLASS_CATEGORY LIKE "%HOUSE%"
OR BUILDING_CLASS_CATEGORY LIKE "%HOME%"
OR BUILDING_CLASS_CATEGORY LIKE "%DWELLINGS%"
OR BUILDING_CLASS_CATEGORY LIKE "%APARTMENT%"
GROUP BY YEAR_BUILT  -- count the number of house each year
ORDER BY YEAR_BUILT),

--Exhibit how many house sold in every year
    b AS(
SELECT EXTRACT(YEAR FROM SALE_DATE) AS YEAR_SALE, COUNT(ADDRESS) AS sold_of_house
FROM `ba775-teamproject-b1.teamproject.processed_data`
WHERE BUILDING_CLASS_CATEGORY LIKE "%CONDO%"
OR BUILDING_CLASS_CATEGORY LIKE "%HOUSE%"
OR BUILDING_CLASS_CATEGORY LIKE "%HOME%"
OR BUILDING_CLASS_CATEGORY LIKE "%DWELLINGS%"
OR BUILDING_CLASS_CATEGORY LIKE "%APARTMENT%"
GROUP BY YEAR_SALE  -- count the number of house each year
ORDER BY YEAR_SALE),

--Exhibit the Total Construction Spending in every year
    c AS (
SELECT EXTRACT(YEAR FROM DATE) AS YEAR_TCS, SUM(TLRESCONS) AS TCS
FROM `ba775-teamproject-b1.teamproject.total_cons_spend`
GROUP BY YEAR_TCS  -- count the number of house each year
ORDER BY YEAR_TCS) 

--Joining 3 tables together
SELECT a.YEAR, built_of_house, sold_of_house, (TCS/1000) AS new_TCS_in_thousand
FROM a 
JOIN b on a.YEAR = b.YEAR_SALE
JOIN c on b.YEAR_SALE = c.YEAR_TCS
ORDER BY YEAR;

--Line graph can be drawn here. 
