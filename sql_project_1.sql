-- USE sql_project_1
SELECT * FROM retail_sales

-- count
SELECT COUNT(*)
FROM retail_sales

-- null values
SELECT * FROM retail_sales
WHERE total_sale IS NULL

SELECT * FROM retail_sales
WHERE cogs IS NULL

SELECT * FROM retail_sales
WHERE price_per_unit IS NULL

SELECT * FROM retail_sales
WHERE quantiy IS NULL

SELECT * FROM retail_sales
WHERE age IS NULL


-- Deleting nulls only the same one 

DELETE FROM retail_sales
WHERE cogs IS NULL

-- Data Exploration
-- How many sales we have ?
SELECT COUNT(*) AS table_sales
FROM retail_sales

-- How many unique customers we have 
SELECT COUNT (DISTINCT customer_id) AS customer_no
FROM retail_sales

-- How many unique category we have
SELECT  DISTINCT category AS categories
FROM retail_sales

-- Data Analysis & business key problems

/* 1. Write a SQL query to
retrieve all columns for sales made on '2022-11-05' */

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05'

/* 2.Write a SQL query to retrieve all transactions where
the category is 'Clothing' and the quantity sold is more 
than 4 in the month of Nov-2022*/

SELECT
	*
FROM retail_sales
WHERE category = 'clothing' AND
(sale_date >= '2022-11-01' AND sale_date <='2022-11-30')
AND quantiy >= 4

/*3.Write a SQL query to calculate the total sales
(total_sale) for each category */

SELECT 
	category,
	SUM(total_sale) AS total_sales,
	COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category

/*4.Write a SQL query to find the average age of customers
who purchased items from the 'Beauty' category.*/
SELECT AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'beauty'

/*5.Write a SQL query to find all transactions 
where the total_sale is greater than 1000.*/
SELECT * FROM retail_sales
WHERE total_sale > 1000

/*6.Write a SQL query to find the total number of transactions
(transaction_id) made by each gender in each category.*/
SELECT category, gender,COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY category,gender

/*7.Write a SQL query to calculate the average sale for 
each month. Find out best selling month in each year*/

SELECT YEAR(sale_date) AS yr,
	   MONTH(sale_date) AS mnth,
	   ROUND(avg(total_sale),2) AS avg_sale
FROM retail_sales
GROUP BY YEAR(sale_date),MONTH(sale_date)
ORDER BY YEAR(sale_date),avg_sale DESC

/*8.Write a SQL query to find the top 5 customers based
on the highest total sales*/
SELECT TOP 5 customer_id,SUM(total_sale) AS total_sales FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC


/*9.Write a SQL query to find the number of unique
customers who purchased items from each category*/

SELECT category,
COUNT(DISTINCT(customer_id)) count_of_unique_cust
FROM retail_sales
GROUP BY category



/*10.Write a SQL query to create each shift
and number of orders 
(Example Morning <12, Afternoon Between 12 & 17, Evening >17)*/
WITH hourly_sale
AS
(SELECT*,
	CASE 
		WHEN DATEPART(HOUR,sale_time) <12 THEN 'Morning'
		WHEN DATEPART(HOUR,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift_
FROM retail_sales)
SELECT shift_,
	   COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift_

-- End of Project