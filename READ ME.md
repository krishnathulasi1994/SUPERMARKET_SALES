# SUPERMARKET SALES ANALYSIS WITH SQL
![](https://github.com/krishnathulasi1994/SUPERMARKET_SALES/blob/main/SUPERMARKET%20LOGO)


## Project Overview
The "Supermarket Sales Analysis" project aims to analyze transactional data from a supermarket to derive actionable insights for improving sales performance, customer engagement, and operational efficiency. By examining factors such as customer demographics, product preferences, and payment methods, this project seeks to enhance decision-making for marketing, inventory, and financial planning.

## Objective
The main objectives of this project are:

1.To understand customer purchasing behavior by analyzing sales data.

2.To identify the most and least popular product lines.

3.To analyze revenue contribution by city, branch, and customer type.

4.To determine the effectiveness of different payment methods and time-based sales trends.

5.To calculate key metrics like gross income and profit margins for optimizing operational strategies.

## Dataset
Source: The dataset represents transactional data from a supermarket(KAGGLE).

Key Attributes:

--Invoice ID: Unique identifier for each transaction.

--Branch & City: Location details of the supermarket branch.

--Customer Type: Categorized as "Member" or "Normal."

--Gender: Gender of the customer.

--Product Line: Product categories such as "Health and Beauty" or "Electronics."

--Unit Price: Price per unit of a product.

--Quantity: Quantity of items purchased.

--Tax (5%): Calculated tax for the transaction.

--Total: Total transaction value including tax.

--Date & Time: Date and time of the transaction.

--Payment Method: Methods like "Cash," "E-wallet," or "Credit card."

--COGS (Cost of Goods Sold): Cost incurred for sold items.

--Gross Margin Percentage: Profit margin percentage.

--Gross Income: Gross income from sales.

--Rating: Customer satisfaction rating.


## Schema
Table Name: supermarket_sales

Column Name	Data Type	Description

--invoice_id	VARCHAR(10)	Unique identifier for each transaction.

--branch	VARCHAR(10)	Branch of the supermarket (e.g., "A," "B," "C").

--city	VARCHAR(20)	City where the branch is located.

--customer_type	VARCHAR(10)	Type of customer ("Member" or "Normal").

--gender	VARCHAR(10)	Gender of the customer ("Male" or "Female").

--product_line	VARCHAR(30)	Product category purchased.

--unit_price	DECIMAL	Price per unit of a product.

--quantity	INTEGER	Number of units purchased.

--tax	FLOAT	Calculated 5% tax on the total value.

--total	DECIMAL	Total transaction value including tax.

--date	VARCHAR	Date of the transaction in YYYY-MM-DD format.

--time	TIME	Time of the transaction in 24-hour format (HH:MM).

--payment	VARCHAR(20)	Payment method ("Cash," "E-wallet," "Credit card").

--cogs	DECIMAL	Cost of goods sold for the transaction.

--gross_margin_percentage	FLOAT	Gross margin percentage for the transaction.

--gross_income	DECIMAL	Gross income from the transaction.

--rating	DECIMAL	Customer satisfaction rating (1 to 10).
