# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `retail_sales_practise`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup 

- **Database Creation**: The project starts by creating a database named `Retail_sales_practise`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT *
FROM retail_sales
WHERE 
    Transactions_id IS NULL
    OR sale_date IS NULL 
    OR sale_time IS NULL 
    OR customer_id IS NULL 
    OR  gender IS NULL 
    OR age IS NULL 
    OR category IS NULL 
    OR  quantiy IS NULL 
    OR price_per_unit IS NULL 
    OR cogs IS NULL
    OR Total_sale  IS NULL  
;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Correcting the error on the Column name
ALTER TABLE retail_sales RENAME COLUMN `ï»¿transactions_id` TO `Transactions_id`;

ALTER TABLE retail_sales RENAME COLUMN `quantiy` TO `quantity`;

```

### 4. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. ****Write a sql query to calculate the total sales from each category.**:
```sql
SELECT category, SUM(total_sale), count(*) AS total_order
FROM retail_sales
GROUP BY category;
```

2. **Write SQL query to find the average age of customers who purchased items from the Beauty category**:
```sql
SELECT category, ROUND(avg(age),2)
FROM retail_sales
GROUP BY category
HAVING category = 'Beauty'
;
```

3. **Write a sql query to find  all transaction where total_sale is greater 1000.**:
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

6. **Write a sql query to find total number of transaction (tarnsaction_id) made by each gender in each category**:
```sql
SELECT  category,
gender,
count(transactions_id) AS total_transaction_gen
FROM retail_sales
group by category, gender
Order by category;
```

7. **Write a sql query to calculate the average sale for each month. find out best selling month in each YEAR**:
```sql
SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, ROUND(AVG(total_sale),2)
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY YEAR(sale_date), MONTH(sale_date)
;

SELECT year, month, t_sal
FROM
(SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, ROUND(AVG(total_sale),2) AS t_sal,
RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY ROUND(AVG(total_sale),2) DESC) AS rank_yr
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)) T1
WHERE rank_yr = 1
;
```

8. **#Write a sql query to retrieve all columns for sale made on 2022-11-05**:
```sql
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05'
;
```

9. **Write a sql query to find the top 5 customers based on the highest total sale**:
```sql
SELECT customer_id, SUM(total_sale)
FROM retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5
;
```

10. **Write the sql query to find the number of unique customers who purchased item from each category**:
```sql
SELECT COUNT(DISTINCT customer_id), category
FROM retail_sales
GROUP BY category
;
```
11. **Write the sql query to create each shift and number of orders (Examples morning < 12, Afternoon Between 12 & 17, Evening > 17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - John Akinrinade

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- **Instagram**: [Follow me for daily tips and updates](https://www.instagram.com/valenjohnex/)
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/john-akinrinade/)

Thank you for your support, and I look forward to connecting with you!
