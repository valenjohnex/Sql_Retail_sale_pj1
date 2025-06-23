SELECT * FROM retail_sales_practise.retail_sales;
#Correct the error on the Column name
ALTER TABLE retail_sales RENAME COLUMN `ï»¿transactions_id` TO `Transactions_id`;

SELECT *
FROM retail_sales;

# Write a sql query to calculate the total sales from each category

SELECT category, SUM(total_sale), count(*) AS total_order
FROM retail_sales
GROUP BY category;

#Write SQL query to find the average age of customers who purchased items from the Beauty category

SELECT category, ROUND(avg(age),2)
FROM retail_sales
GROUP BY category
HAVING category = 'Beauty'
;

SELECT *
FROM retail_sales;

#Write a sql query to find  all transaction where total_sale is greater 1000

SELECT *
FROM retail_sales
WHERE total_sale > 1000
;

#Write a sql query to find total number of transaction (tarnsaction_id) made by each gender in each category

SELECT  category, gender, count(transactions_id) AS total_transaction_gen
FROM retail_sales
group by category, gender
Order by category
;

#Write a sql query to calculate the average sale for each month. find out best selling month in each YEAR

SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, ROUND(AVG(total_sale),2)
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY YEAR(sale_date), MONTH(sale_date)
;

SELECT year, month, T_sal
FROM
(SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, ROUND(AVG(total_sale),2) AS T_sal,
RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY ROUND(AVG(total_sale),2) DESC) AS rank_yr
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)) T1
WHERE rank_yr = 1
;

#Write a sql query to retrieve all columns for sale made on 2022-11-05
SELECT * FROM retail_sales;

SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05'
;

#Write a sql query to find the top 5 customers based on the highest total sale
SELECT * FROM retail_sales;

SELECT customer_id, SUM(total_sale)
FROM retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5
;

#Write the sql query to find the number of unique customers who purchased item from each category
SELECT * FROM retail_sales;

SELECT COUNT(DISTINCT customer_id), category
FROM retail_sales
GROUP BY category
;

#Write the sql query to create each shift and number of orders (Examples morning < 12, Afternoon Between 12 & 17, Evening > 17)

SELECT *,
CASE 
	WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFternoon'
    ELSE 'Evening'
    END AS Shift
    FROM retail_sales;
  
  WITH shift_pattern
  AS (
    SELECT *,
CASE 
	WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFternoon'
    ELSE 'Evening'
    END AS Shift
    FROM retail_sales)
    SELECT shift, count(*) AS total_orders
    FROM shift_pattern
    group by shift
    ;
    
    #End of Project