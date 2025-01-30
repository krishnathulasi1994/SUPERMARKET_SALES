DROP TABLE IF EXISTS SUPERMARKET_SALES;
CREATE TABLE SUPERMARKET_SALES
(
	INVOICE_ID VARCHAR(20),
	BRANCH VARCHAR(15),
	CITY VARCHAR(20),
	CUSTOMER_TYPE VARCHAR(10),
	GENDER VARCHAR(10),
	PRODUCT_LINE VARCHAR(30),
	UNIT_PRICE DECIMAL(8,2),
	QUANTITY INT,
	TAX DECIMAL(10,2),
	TOTAL DECIMAL(10,2),
	DATE VARCHAR(15),
	PAYMENT VARCHAR(20),
	COGS DECIMAL(8,2),
	GROSS_MARGIN_PERCENTAGE DECIMAL(15,2),
	GROSS_INCOME DECIMAL(10,2),
	RATING DECIMAL(4,2)

);
	
ALTER TABLE SUPERMARKET_SALES
ADD COLUMN "time" TIME;

SELECT * from supermarket_sales;


---1.Rank the products by total sales for each branch.

SELECT * from supermarket_sales

select 
	branch,
	product_line,
	sum(total) 
from
	supermarket_sales
group by product_line,branch
order by sum(total) desc;


---USING RANK FUNCTION
select 
	branch,
	product_line,
	rank() over(partition by branch order by sum(total) desc)as rank 
from supermarket_sales
group by branch,product_line
order by branch,rank;


---2.Find the top 3 products with the highest sales across all branches.

SELECT * from supermarket_sales

SELECT 
	PRODUCT_LINE,
	SUM(TOTAL)
FROM SUPERMARKET_SALES
GROUP BY PRODUCT_LINE
ORDER BY SUM(TOTAL) DESC
LIMIT 3


---3.Calculate the average rating per city for each product line.

SELECT * from supermarket_sales

SELECT 
	PRODUCT_LINE,
	CITY,
	ROUND(AVG(RATING),2) AS AVERAGE_RATING
FROM SUPERMARKET_SALES
GROUP BY PRODUCT_LINE,CITY

---4.Find the branch with the highest total sales and the city it belongs to.

SELECT 
	BRANCH,
	CITY,
	SUM(TOTAL) AS TOTAL_SALES
FROM SUPERMARKET_SALES
GROUP BY BRANCH,CITY
ORDER BY TOTAL_SALES DESC
LIMIT 1;

--- USING SUBQUERY

SELECT
	BRANCH,
	CITY,
	SUM(TOTAL)
FROM SUPERMARKET_SALES
WHERE BRANCH=(
			SELECT BRANCH
			FROM SUPERMARKET_SALES
			GROUP BY BRANCH
			ORDER BY SUM(TOTAL) DESC
			LIMIT 1
			)
GROUP BY CITY,BRANCH
ORDER BY SUM(TOTAL)
LIMIT 1
			
---5.Calculate the percentage of total sales for each product line.

SELECT * from supermarket_sales

SELECT 
	PRODUCT_LINE,
	SUM(TOTAL),
	ROUND((SUM(TOTAL))/SUM(SUM(TOTAL))OVER()*100,2) AS PERCENTAGE_OF_TOTAL_SALES
FROM SUPERMARKET_SALES
GROUP BY
	PRODUCT_LINE
ORDER BY 
	PERCENTAGE_OF_TOTAL_SALES


---6.Find the highest and lowest unit prices for each product line.

SELECT 
	PRODUCT_LINE,
	MAX(UNIT_PRICE) AS HIGHEST_UNIT_PRICE,
	MIN(UNIT_PRICE) AS LOWEST_UNIT_PRICE
FROM SUPERMARKET_SALES
GROUP BY PRODUCT_LINE

---7.Find the total number of transactions for each customer type.

SELECT 
		CUSTOMER_TYPE,
		COUNT(invoice_id)
from supermarket_sales
group by customer_type

---8. List the cities that have a branch with the highest total sales for each product line.

SELECT * from supermarket_sales
---USING CTE 

WITH TOTAL_SALES_CTE AS(
		SELECT 
			CITY,
			BRANCH,
			PRODUCT_LINE,
			SUM(TOTAL),
			RANK()OVER (PARTITION BY PRODUCT_LINE ORDER BY SUM(TOTAL)DESC) AS RANK
		FROM SUPERMARKET_SALES
		GROUP BY BRANCH,CITY,PRODUCT_LINE
)

SELECT CITY,PRODUCT_LINE,BRANCH
FROM TOTAL_SALES_CTE
WHERE RANK=1


---9.Find customers who have made purchases in multiple branches.
SELECT * from supermarket_sales

SELECT CUSTOMER_TYPE,COUNT(DISTINCT BRANCH) AS NUMBER_OF_BRANCHES
FROM SUPERMARKET_SALES
GROUP BY CUSTOMER_TYPE
HAVING COUNT(DISTINCT BRANCH)>1


---10.Identify the products that contributed to at least 10% of total sales for each branch.

SELECT * from supermarket_sales

WITH SALES_CTE AS(
SELECT 
	BRANCH,
	PRODUCT_LINE,
	SUM(TOTAL) AS PRODUCT_TOTAL,
	SUM(SUM(TOTAL))OVER(PARTITION BY BRANCH)AS BRANCH_TOTAL
FROM SUPERMARKET_SALES
GROUP BY PRODUCT_LINE,BRANCH)
SELECT PRODUCT_LINE,BRANCH,PRODUCT_TOTAL,ROUND((PRODUCT_TOTAL/BRANCH_TOTAL)*100,2) AS PER_OF_TOTAL_SALES_FOR_BRanch
FROM SALES_CTE
WHERE( PRODUCT_TOTAL/BRANCH_TOTAL)*100>=10
order by PER_OF_TOTAL_SALES_FOR_BRanch desc

---11.Identify the most profitable day for each branch.

SELECT * from supermarket_sales


with profit_day_cte as
	(
	select
	branch,
	date,
	sum(gross_income) as day_income,
	rank()over(partition by branch order by sum(gross_income)
	desc) as rank
	from supermarket_sales
	group by branch,date)
select 	branch,date,day_income 
from profit_day_cte
where rank =1
group by branch,date,day_income


---12.Find the top 3 cities with the highest average rating for female customers.

select 
	city,
	avg(rating) as highest_avg_rating

from supermarket_sales
where gender='Female'
group by city
order by highest_avg_rating desc
limit 3

---13.Compare the total sales of different payment methods for male vs. female customers.

SELECT PAYMENT,
		SUM(CASE WHEN GENDER='Male' THEN TOTAL ELSE 0 END)AS MALE_TOTAL_SALES,
		SUM(CASE WHEN GENDER='Female' THEN TOTAL ELSE 0 END)AS FEMALE_TOTAL_SALES

FROM SUPERMARKET_SALES
GROUP BY PAYMENT
ORDER BY PAYMENT

---14. Find the branch-product combinations that generated average revenue above the branch's average.

SELECT * from supermarket_sales

WITH 
BRANCH_AVERAGE_CTE AS
(
	SELECT 
		BRANCH,
		AVG(TOTAL) AS BRANCH_AVERAGE
	FROM SUPERMARKET_SALES
	GROUP BY BRANCH
)

SELECT 
	S.BRANCH,
	S.PRODUCT_LINE,
	ROUND(AVG(TOTAL),2)AS PRODUCT_TOTAL,ROUND(B.BRANCH_AVERAGE,2) AS BRANCH_AVERAGE
FROM SUPERMARKET_SALES AS S 
JOIN BRANCH_AVERAGE_CTE AS B
ON S.BRANCH=B.BRANCH
GROUP BY S.BRANCH,S.PRODUCT_LINE,B.BRANCH_AVERAGE
HAVING AVG(S.TOTAL)>BRANCH_AVERAGE
ORDER BY PRODUCT_TOTAL





