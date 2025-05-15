SELECT * FROM shopping_trends;
    
--Question 1: Find all records where Size is missing and the purchase_amount is greater than 50

SELECT Customer_ID,
       Size,
       purchase_amount,
       item_purchased, 
FROM shopping_trends
WHERE size IS NULL AND purchase_amount > 50;

--Question 2: List the total number of purchases grouped by Season, treating NULL values as 'Unknown Season'

SELECT COUNT(*) AS Total_purchases,
       IFNULL(season, 'Unknown Season') As Season_new
FROM shopping_trends
GROUP BY IFNULL(Season, 'Unknown Season'); 

--Question three: Count how many customers used each Payment Method, treating NULLs as 'Not Provided'

SELECT COUNT(*) AS customer_count,
       IFNULL(payment_method,'Not Provided') AS payment_method
FROM shopping_trends
GROUP BY ALL;       

--Question 4: Show customers where Promo Code Used is NULL and Review Rating is below 3.0

SELECT promo_code_used,
       review_rating
FROM shopping_trends
WHERE promo_code_used IS NULL AND review_rating < 3.0;

--Question 5: Group customers by Shipping Type, and return the average purchase_amount, treating missing values as 0       

SELECT shipping_type,
       AVG ( IFNULL(purchase_amount, 0)) AS Average_purchase_amount,
FROM shopping_trends
GROUP BY shipping_type;

--Question 6:Display the number of purchases per Location only for those with more than 5 purchases and no NULL Payment Method
       
SELECT Location,
       COUNT(*) AS Total_putchases,
FROM shopping_trends
WHERE payment_method IS NOT NULL
GROUP BY location
HAVING COUNT(*) > 5;

--Question 7:Create a column Spender Category that classifies customers using CASE: 
-- 'High' if amount > 80, 'Medium' if BETWEEN 50 AND 80, 
-- 'Low' otherwise. 
--Replace NULLs in purchase_amount with 0
--Customer ID, purchase_amount, Spender Category

SELECT customer_id,
       IFNULL(purchase_amount, 0) AS purchase_amount,
       CASE
       WHEN purchase_amount > 80 THEN 'High'
       WHEN purchase_amount BETWEEN 50 AND 80 THEN'Meduim'
       ELSE 'Low'
     END AS spender_category
FROM shopping_trends;

--Question 8: Find customers who have no Previous 
-- Purchases value but whose Color is not NULL.
-- Expected Columns: Customer ID, Color, Previous Purchases

SELECT customer_id,
       color,
       previous_purchases,
FROM shopping_trends
WHERE color IS NOT NULL AND previous_purchases IS NULL;

--Question 9: Group records by Frequency of Purchases and show the total amount spent per group, treating NULL frequencies as 'Unknown'.
-- Expected Columns: Frequency of Purchases, Total purchase_amount

SELECT frequency_of_purchases,
       COUNT(*) AS Total_purchase_amount
       
FROM shopping_trends
GROUP BY frequency_of_purchases;

--Question 10: Display a list of all Category values with the number of times each was purchased, excluding rows where Categoryis NULL.
-- Expected Columns: Category, Total Purchases

SELECT category,
       COUNT(*) AS Total_purcahses,
FROM shopping_trends
WHERE category IS NULL
GROUP BY category;  

--Question 11:.Return the top 5 Locations with the highest total purchase_amount, replacing NULLs in amountwith 0.
-- Expected Columns: Location, Total purchase_amount

SELECT location,
       SUM(IFNULL(purchase_amount,0)) AS total_purchase_amount,
FROM shopping_trends
GROUP BY location
ORDER BY SUM(purchase_amount) DESC LIMIT 5;

--Question 12:.Group customers by Gender and Size, and count how many entries have a NULL Color.
-- Expected Columns: Gender, Size, Null Color Count

SELECT gender,
       size,
       COUNT(*) AS number_entries,
FROM shopping_trends
WHERE color IS NULL
GROUP BY gender, size;

--Question 13: .Identify all Item Purchased where more than 3 purchases had NULL Shipping Type.
-- Expected Columns: Item Purchased, NULL Shipping Type Count

SELECT item_purchased,
       COUNT(*) AS null_shipping_tyoe_count,
FROM shopping_trends
WHERE shipping_type IS NULL
GROUP BY item_purchased
HAVING COUNT(*) > 3;

--Question 14: .Show a count of how many customers per Payment Method have NULL Review Rating.
-- Expected Columns: Payment Method, Missing Review Rating Count

SELECT payment_method,
       COUNT(*) AS missing_review_rating_count,
FROM shopping_trends
WHERE review_rating IS NULL
GROUP BY payment_method;

--Question 15: .Group by Category and return the average Review Rating, replacing NULLs with 0, and filter only where average is greater than 3.5.
-- Expected Columns: Category, Average Review Rating

SELECT category,
       AVG(IFNULL(review_rating,0)) AS average_review_rating
FROM shopping_trends
GROUP BY category
HAVING AVG(IFNULL(review_rating,0)) > 3.5;     ---EMPTY TABLE

---Question 16: List all Colors that are missing (NULL) in at least 2 rows and the average Age of customers for those rows.
-- Expected Columns: Color, Average Age

SELECT color,
       AVG(age) AS Average_age
FROM shopping_trends
WHERE color IS NULL 
GROUP BY color
HAVING COUNT(*) >= 2;

--Question 17: Use CASE to create a column Delivery Speed: 'Fast' if Shipping Type is 'Express' or 
-- 'Next Day Air', 'Slow' if 'Standard', 
-- 'Other' for all else including NULL. Then count how many customers fall into
-- each category.
-- Expected Columns: Delivery Speed, Customer Count

SELECT COUNT(*) AS Customer_count,
     CASE
      WHEN shipping_type IN ('Express', 'Next Day Air') THEN 'Fast'
      WHEN shipping_type = 'Standard' THEN 'Slow'
      ELSE 'Other'
      END AS Delivery_Speed
FROM shopping_trends
GROUP BY Delivery_Speed;

--Question 18: Find customers whose purchase_amount is NULL and whose Promo Code Used is 'Yes'.
-- Expected Columns: Customer ID, purchase_amount, Promo Code Used

SELECT customer_id,
       purchase_amount,
       promo_code_used,
FROM shopping_trends
WHERE purchase_amount IS NULL AND promo_code_used = 'Yes';

--Question 19: .Group by Location and show the maximum Previous Purchases,replacing NULLs with 0, only where the average rating is above 4.0.
-- Expected Columns: Location, Max Previous Purchases, Average 
-- Review Rating

SELECT location,
       MAX(IFNULL(previous_purchases,0)) AS Max_previous_purchases,
       AVG(review_rating) AS Average_review_rating
FROM shopping_trends
GROUP BY location
HAVING AVG(review_rating) > 4.0;      --EMPTY TABLE

--Question 20: Show customers who have a NULL Shipping Type but made a purchase in the range of 30 to 70 USD.
-- Expected Columns: Customer ID, Shipping Type, purchase_amount, Item Purchase

SELECT customer_id,
       shipping_type,
       purchase_amount,
       item_purchased
FROM shopping_trends
WHERE shipping_type IS NULL 
AND purchase_amount BETWEEN 30 AND 70;