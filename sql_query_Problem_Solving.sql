-- Data Analysis and Problem Solving
SELECT * FROM Retail_Sales;

-- Qustions:
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
SELECT * 
FROM Retail_Sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022.
SELECT *
FROM Retail_Sales
WHERE category = 'Clothing' 
      AND 
	  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	  AND
	  quantity > 3;

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, SUM(total_sale) AS Total_Sales
FROM Retail_Sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT AVG(age) AS Average_age
FROM Retail_Sales
WHERE category = 'Beauty';

-- As the number is too big . To round off in two digits...
SELECT ROUND(AVG(age), 2) AS Average_age
FROM Retail_Sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM Retail_Sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(transactions_id) AS Total_transactions
FROM Retail_Sales
GROUP BY category, 
         gender
ORDER BY category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT YEAR,
       MONTH,
	   Average_sales
FROM( 
       SELECT EXTRACT (YEAR FROM sale_date) AS YEAR ,
              EXTRACT (MONTH FROM sale_date) AS MONTH,
              AVG(total_sale) as Average_sales,
	          RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS Rank
       FROM Retail_Sales
       GROUP BY YEAR,
                MONTH
) 
WHERE Rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
SELECT customer_id,
       SUM(total_sale) AS Total_sales
FROM Retail_Sales
GROUP BY customer_id
ORDER BY Total_sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,
       COUNT(DISTINCT customer_id) AS Unique_customer
FROM Retail_Sales
GROUP BY category;
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH Hourly_sales
AS
(
SELECT *,
       CASE
	       WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
	       WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
	       ELSE 'EVENING'
	   END AS shifts
FROM Retail_Sales
)
SELECT shifts,
       COUNT(*) AS Total_orders
FROM hourly_sales
GROUP BY shifts;
