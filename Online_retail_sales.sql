CREATE DATABASE RETAIL;
USE RETAIL;

CREATE TABLE retail_sales
 (
     transactions_id INT PRIMARY KEY,
     sale_date DATE,	
     sale_time TIME,
     customer_id INT,	
     gender VARCHAR(10),
     age INT,
     category VARCHAR(35),
     quantity INT,
     price_per_unit FLOAT,	
     cogs FLOAT,
     total_sale FLOAT
 );
 
 -- ### 2. Data Exploration & Cleaning

-- - **Record Count**: Determine the total number of records in the dataset.

SELECT COUNT(transactions_id)
FROM retail_sales;


-- - **Customer Count**: Find out how many unique customers are in the dataset.

SELECT COUNT(distinct transactions_id) uniquee
FROM retail_sales;

-- - **Category Count**: Identify all unique product categories in the dataset.

SELECT DISTINCT Category 
FROM retail_sales;

-- count of unique items in category

 SELECT COUNT(DISTINCT category) as unique_Cat
FROM Retail_sales;

-- - **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

SELECT * FROM retail_sales
WHERE 
sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
gender IS NULL OR age IS NULL OR category IS NULL OR 
quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;


-- ### 3. Data Analysis & Findings

-- The following SQL queries were developed to answer specific business questions:

-- 1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'
ORDER BY sale_time ;

-- 2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
  
  
SELECT 
   *
FROM 
   retail_sales
WHERE 
   category = 'Clothing'
   AND 
   DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
   AND
   quantity >= 4
   ORDER BY sale_time ASC;

-- 3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

SELECT 
    category,
    COUNT(*) AS total_orders,
    SUM(total_sale) AS total_Sales
FROM
    retail_sales
GROUP BY 1
ORDER BY 2 , 3;

-- 4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

 SELECT
 ROUND(AVG(age), 2) as avg_age
 FROM retail_sales
 WHERE category = 'Beauty';


-- 5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

SELECT *
FROM retail_sales
WHERE TOTAL_SALE > 1000
ORDER BY TOTAL_SALE;

--  6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

SELECT count(transactions_id) total_num_trans , gender, category
FROM retail_sales
GROUP BY 2,3
ORDER BY 1;


-- 7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
 
SELECT 
    year,
    month,
    avg_sale
FROM 
(    
    SELECT 
        EXTRACT(YEAR FROM sale_date) as year,
        EXTRACT(MONTH FROM sale_date) as month,
        AVG(total_sale) as avg_sale,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as ranked
    FROM retail_sales
    GROUP BY 1, 2
) as t1
WHERE ranked = 1;

-- 8. **Write a SQL query to find the top 5 customers based on the highest total sales **:

select *
from retail_sales;

SELECT customer_id, sum(total_Sale) as total
from retail_sales
group by 1
order by 2 desc
limit 5 ;

-- 9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

SELECT count(DISTINCT customer_id) as unique_Customers, category
FROM retail_sales
GROUP BY category;

-- 10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

select *
from retail_sales;

WITH hourly_Sales AS (
SELECT *,
CASE 
WHEN EXTRACT(HOUR FROM Sale_Time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM Sale_Time) BETWEEN 12 AND 17	THEN 'Afternoon'
ELSE 'Evening'
 END AS shift
 FROM retail_sales
 )
 SELECT
 Shift, COUNT(*) AS Total_Orders
 FROM hourly_sales
 GROUP BY Shift;

-- ## Findings

-- - **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
-- - **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
-- - **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
-- - **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

-- ## Reports

-- - **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
-- - **Trend Analysis**: Insights into sales trends across different months and shifts.
-- - **Customer Insights**: Reports on top customers and unique customer counts per category.

-- ## Conclusion

-- This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
