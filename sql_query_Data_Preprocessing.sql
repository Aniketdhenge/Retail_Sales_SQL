-- SQL Project: 01

-- Create Database
CREATE DATABASE Retail_Sales_Analysis;

-- Create Tables
DROP TABLE IF EXISTS Retail_Sales;
CREATE TABLE Retail_Sales (
            transactions_id	INT PRIMARY KEY,
            sale_date DATE,
			sale_time TIME,
			customer_id	INT,
			gender VARCHAR(15),
			age INT,	
			category VARCHAR(15),
			quantity INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT
);

SELECT * FROM Retail_Sales;

SELECT COUNT(*) FROM Retail_Sales;

-- Step-1: Data Cleaning

SELECT * FROM Retail_Sales
WHERE transactions_id IS NULL;

SELECT * FROM Retail_Sales
WHERE sale_date IS NULL;

SELECT * FROM Retail_Sales
WHERE sale_time IS NULL;

SELECT * FROM Retail_Sales
WHERE customer_id IS NULL;

SELECT * FROM Retail_Sales
WHERE gender IS NULL;

SELECT * FROM Retail_Sales
WHERE age IS NULL;

-- Another and most effective way to find null values
SELECT * FROM Retail_Sales
WHERE  
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR 
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR 
	 quantity IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR 
	 total_sale IS NULL;

-- Deleting NULL records
DELETE FROM Retail_Sales
WHERE  
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR 
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR 
	 quantity IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR 
	 total_sale IS NULL;

-- Step-2: Data Exploration

-- How many sales we have ?
SELECT COUNT(*) AS Total_Sales FROM Retail_Sales;

-- How many customers we have ?
SELECT COUNT(customer_id) AS Customers FROM Retail_Sales;

-- How many unique customers we have ?
SELECT COUNT(DISTINCT customer_id) AS Customers FROM Retail_Sales;

-- How many unique categories we have ?
SELECT DISTINCT category FROM Retail_Sales;




