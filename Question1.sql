#Question 1 
#How do the types of buildings affect their selling price in relation to their square footage? (Are there building types with specific square footage enjoying higher selling prices?)

SELECT  BUILDING_CLASS_CATEGORY, 
        ROUND(AVG(SALE_PRICE/GROSS_SQUARE_FEET)) AS price_per_square
FROM ba775-teamproject-b1.teamproject.processed_data
GROUP BY BUILDING_CLASS_CATEGORY
ORDER BY price_per_square DESC
LIMIT 5; --There are 49 categories in total, 
          --Keep the first 10 with the highest average price per sqaure. 

#From the first 10 categories, we can roughly tell that buildings of tax classes and condos are relatively more expensive compared to other categories. 

