#4.1
SELECT DISTINCT NEIGHBORHOOD 
FROM ba775-teamproject-b1.teamproject.nycdata;
#There appears to be neighborhoods without names but numbers. 

SELECT DISTINCT NEIGHBORHOOD
FROM  ba775-teamproject-b1.teamproject.nycdata
WHERE NEIGHBORHOOD NOT LIKE '%0%'
AND NEIGHBORHOOD NOT LIKE '%1%'
AND NEIGHBORHOOD NOT LIKE '%2%'
AND NEIGHBORHOOD NOT LIKE '%3%'
AND NEIGHBORHOOD NOT LIKE '%4%'
AND NEIGHBORHOOD NOT LIKE '%5%'
AND NEIGHBORHOOD NOT LIKE '%6%'
AND NEIGHBORHOOD NOT LIKE '%7%'
AND NEIGHBORHOOD NOT LIKE '%8%'
AND NEIGHBORHOOD NOT LIKE '%9%'; 
#Excluding all neighborhoods with no names with numbers. 

SELECT COUNT(DISTINCT NEIGHBORHOOD) AS Neighbor_Count
FROM ba775-teamproject-b1.teamproject.nycdata
WHERE NEIGHBORHOOD NOT LIKE '%0%'
AND NEIGHBORHOOD NOT LIKE '%1%'
AND NEIGHBORHOOD NOT LIKE '%2%'
AND NEIGHBORHOOD NOT LIKE '%3%'
AND NEIGHBORHOOD NOT LIKE '%4%'
AND NEIGHBORHOOD NOT LIKE '%5%'
AND NEIGHBORHOOD NOT LIKE '%6%'
AND NEIGHBORHOOD NOT LIKE '%7%'
AND NEIGHBORHOOD NOT LIKE '%8%'
AND NEIGHBORHOOD NOT LIKE '%9%'; 
#There are 500 different neighborhoods in NYC that are with nanmes. 

#4.2
SELECT ADDRESS, GROSS_SQUARE_FEET
FROM  ba775-teamproject-b1.teamproject.nycdata 
WHERE GROSS_SQUARE_FEET IS NULL
LIMIT 5; 
#There are null values in gross square feet, we will only analyze buildings with gross square feet larger than 1. 

SELECT ADDRESS, SALE_PRICE
FROM ba775-teamproject-b1.teamproject.nycdata
WHERE SALE_PRICE = 0
LIMIT 5; 
#There are sale prices equal to $0, which suggests that there are buildings that were never sold.
#We will only analyze buildings with sale price larger than $1 (considering there will be buildings that are gifted for a very low price)

SELECT ADDRESS, YEAR_BUILT
FROM ba775-teamproject-b1.teamproject.nycdata
WHERE YEAR_BUILT = 0
LIMIT 5; 
#There are year built values equal to 0, 
#Therefore we will only analyze buildings with year_built larger than 1492 (considering Columbus found America in 1492.) 

SELECT ADDRESS, BUILDING_CLASS_CATEGORY
FROM ba775-teamproject-b1.teamproject.nycdata
WHERE BUILDING_CLASS_CATEGORY IS NULL
#There are no null values in building class category, however, some categories are duplicates due to spacing error. 
#We solve this problem when we are creating a new table. 
