-- sql reatail Sales Analysis -P1 
CREATE DATABASE sql_project_p2;

-- CREATE TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
						(
							transactions_id	INT PRIMARY KEY,
							sale_date	DATE,	
							sale_time	TIME,
							customer_id	INT,
							gender	VARCHAR(50),
							age	INT,
							category VARCHAR(50),	
							quantiy	INT,
							price_per_unit	FLOAT,
							cogs FLOAT,	
							total_sale FLOAT

			
);


SELECT * FROM retail_sales
limit (10)

-- DATA CLEANING
SELECT * FROM retail_sales
where transactions_id is null


SELECT * FROM retail_sales
where sale_date is null

SELECT * FROM retail_sales
where transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null ;



delete FROM retail_sales
where transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null ;


-- DATA EXPLORATION
-- How many sales we have?
SELECT COUNT (*) AS total_sale FROM retail_sales

-- How many customers we have?
SELECT COUNT (DISTINCT customer_id) AS total_sale FROM retail_sales


SELECT COUNT (DISTINCT category) AS total_sale FROM retail_sales


-- DATA ANALYSIS & BUSINESS KEY PROBLEM & ANSWER

--My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all column for sales made on '2022-11-05'
--Q.2 Write a SQl query to retrieve all transaction where the category is 'Clothing' and the quantity sold is more than 10 in
--the month of Nov -2022.
--Q.3 Write a SQL query to calculate the total sales (total_sales) for each category.
--Q.4 Wrie a SQL to find the average age of customer who purchased items from the 'Beauty Category'.
--Q.5 Write a SQl query to find all transaction where the total_sale is greater than 1000.
--Q.6 Write a SQL query to find the total number of transaction (Transaction_id) made by each other in each category .
--Q.7 Write a SQL query to calculate the average sale of each month . Find out best selling month in each year.
--Q.8 Write a SQL query to find top 5 customer based on the highest total sales.
--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).



-- Q.1 Write a SQL query to retrieve all column for sales made on '2022-11-05'

select * 
From retail_sales	
where sale_date = '2022-11-05'



--Q.2 Write a SQl query to retrieve all transaction where the category is 'Clothing' and the quantity sold is more than 4 in
--the month of Nov -2022.


select * 
from retail_sales
where 
	category = 'Clothing' 
	and 
	to_char(sale_date , 'yyyy-mm') = '2022-11'
	and 
	quantiy >= 4



--Q.3 Write a SQL query to calculate the total sales (total_sales) for each category.

select category,
	sum(total_sale) as net_sale,
	count(*) as total_orders
	from retail_sales
	group by 1



--Q.4 Wrie a SQL to find the average age of customer who purchased items from the 'Beauty Category'.

select  
	round (avg(age) ,2)as avg_age
from retail_sales
where category =  'Beauty'


--Q.5 Write a SQl query to find all transaction where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000


--Q.6 Write a SQL query to find the total number of transaction (Transaction_id) made by each other in each category .

select 
	category,
	gender,
	count(*) as total_trans
from retail_sales
group 
	by
	category ,
	gender
order by 1


--Q.7 Write a SQL query to calculate the average sale of each month . Find out best selling month in each year.

select 
	extract (year from sale_date) as year,
	extract (month from sale_date) as month,
	avg(total_sale) as avg_sale,
	rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc)
from retail_sales
group by 1,2
--order by 1,2,3 desc


--Q.8 Write a SQL query to find top 5 customer based on the highest total sales.
select 
	customer_id,
	sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
	category ,
	count(distinct customer_id) as cnt_unique_cs
from retail_sales
group by category


--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).

with hourly_sale
as
(

select *,
	case
		when extract (hour from sale_time) < 12 then 'Morning'
		when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
from retail_sales
)
select 
	shift ,
	count(*) as total_order
from hourly_sale
group by shift

-- End of project
