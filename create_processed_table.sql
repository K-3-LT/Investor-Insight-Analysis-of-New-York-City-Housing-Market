#DON'T RUN THIS UNLESS YOU NEED TO
#We create a new table processed_data including theses changes
CREATE OR REPLACE TABLE ba775-teamproject-b1.teamproject.processed_data AS  -- crreate table an reproducible if it alrady exists
SELECT BOROUGH, NEIGHBORHOOD, CATEGORY_NO_SPACE AS BUILDING_CLASS_CATEGORY, ADDRESS, ZIP_CODE, LAND_SQUARE_FEET, 
        GROSS_SQUARE_FEET, YEAR_BUILT, SALE_PRICE, SALE_DATE
FROM(
SELECT *, REPLACE(BUILDING_CLASS_CATEGORY, ' ', '') AS CATEGORY_NO_SPACE --remove duplicates caused by spacing error
FROM ba775-teamproject-b1.teamproject.nycdata
WHERE BUILDING_CLASS_CATEGORY IS NOT NULL
AND GROSS_SQUARE_FEET > 1.0   -- some are extremely low to 1, which make the price per sqaure too high
AND SALE_PRICE > 0.0  -- excludes buildings that were never sold
AND YEAR_BUILT > 1492 -- excludes some input error (e.g. house's built year is 1000)
AND NEIGHBORHOOD NOT LIKE '%0%'
AND NEIGHBORHOOD NOT LIKE '%1%'
AND NEIGHBORHOOD NOT LIKE '%2%'
AND NEIGHBORHOOD NOT LIKE '%3%'
AND NEIGHBORHOOD NOT LIKE '%4%'
AND NEIGHBORHOOD NOT LIKE '%5%'
AND NEIGHBORHOOD NOT LIKE '%6%'
AND NEIGHBORHOOD NOT LIKE '%7%'
AND NEIGHBORHOOD NOT LIKE '%8%'
AND NEIGHBORHOOD NOT LIKE '%9%'); -- exclude neiborhood mistyping
