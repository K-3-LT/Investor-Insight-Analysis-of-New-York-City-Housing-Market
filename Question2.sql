#Question 2
#How does a building’s age affect its selling price in relation to its building class? (Are there building classes with older/younger age enjoying higher selling prices?) 

SELECT (EXTRACT(YEAR FROM CURRENT_DATE()) - CAST(YEAR_BUILT AS INT)) AS building_age,  -- calculate the building age
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS price_per_square  -- calculate the price per square
FROM ba775-teamproject-b1.teamproject.processed_data 
GROUP BY building_age
ORDER BY building_age, price_per_square DESC

#A line graph can be drawn from here between building age and average price per square feet
