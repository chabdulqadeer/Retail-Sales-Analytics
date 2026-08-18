/*
Project: Retail Sales Analytics
Analysis: SQL Business Analysis
Database: SQL Server
*/

-- First: We create a database -> retail_superdatabase

-- Following query is to search the given database name from sys.databases, if already exists then it, will delete it
-- If not exits, then we'll create it

IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME ='retail_superdatabase')
BEGIN
	DROP DATABASE retail_superdatabase
END

-- Creation of databases

CREATE DATABASE retail_superdatabase;

-- Use this database

USE retail_superdatabase;

-- Step 1 — Load/verify your data

SELECT TOP 10 *
FROM Superstore;

-- Total Rows

SELECT COUNT(*) AS Total_Rows
FROM Superstore;

-- Total Order OR Unique orders

SELECT COUNT(DISTINCT(ORDER_ID)) AS Unique_Orders
FROM Superstore;

-- Step 2 — Total Sales

SELECT ROUND(SUM(SALES),2) AS Total_Sales
FROM Superstore;

-- Step 3 — Total Profit

SELECT ROUND(SUM(PROFIT),2) AS Total_Profit
FROM Superstore;

-- 3.1 - Total Sales, Profit and Profit Margin

SELECT 
	ROUND(SUM(SALES),2) AS Total_Sales,
	ROUND(SUM(PROFIT),2) AS Total_Profit,
	ROUND((SUM(PROFIT) * 100) / SUM(SALES),2) AS Profit_Margin
FROM Superstore;

-- Step 4 — Sales and Profit by Category

SELECT
	Category,
	ROUND(SUM(SALES),2) AS Total_Sales,
	ROUND(SUM(PROFIT),2) AS Total_Profit,
	ROUND((SUM(PROFIT) * 100) / SUM(SALES),2) AS Profit_Margin
FROM Superstore
GROUP BY Category
ORDER BY Profit_Margin DESC
;

-- Step 5 — Find the Worst Furniture Sub-Categories

SELECT
	Sub_Category,
	ROUND(SUM(SALES),2) AS Total_Sales,
	ROUND(SUM(PROFIT),2) AS Total_Profit,
	ROUND((SUM(PROFIT) * 100) / SUM(SALES),2) AS Profit_Margin
FROM Superstore
WHERE Category = 'Furniture'
GROUP BY Sub_Category
ORDER BY Profit_Margin DESC
;

-- Step 6 — Top 10 Products by Profit

SELECT TOP 10
	Product_Name,
	ROUND(SUM(SALES),2) AS Total_Sales,
	ROUND(SUM(PROFIT),2) AS Total_Profit,
	ROUND(SUM(PROFIT) / SUM(SALES) * 100,2) AS Profit_Margin
FROM Superstore
GROUP BY Product_Name
ORDER BY Total_Profit DESC
;

-- Step 7 — Regional Performance

SELECT
	Region,
	ROUND(SUM(SALES),2) AS Total_Sales,
	ROUND(SUM(PROFIT),2) AS Total_Profit,
	ROUND((SUM(PROFIT) * 100) / SUM(SALES),2) AS Profit_Margin
FROM Superstore
GROUP BY Region
ORDER BY Profit_Margin DESC
;

-- Step 8 — Discount Analysis

SELECT
	ROUND(Discount,2) AS Discount,
	ROUND(SUM(SALES),2) AS Total_Sales,
	ROUND(SUM(PROFIT),2) AS Total_Profit,
	ROUND((SUM(PROFIT) * 100) / SUM(SALES),2) AS Profit_Margin
FROM Superstore
GROUP BY Discount
ORDER BY Discount
;

-- Step 9 — A REAL Analyst Query

SELECT 
	Sub_Category,
	ROUND(AVG(DISCOUNT),2) AS [AVerage Discount],
	ROUND(SUM(SALES),2) AS Total_Sales,
	ROUND(SUM(Profit),2) AS Total_Profit,
	ROUND(SUM(Profit) / SUM(Sales) * 100,2) AS [Profit Margin]
FROM superstore
WHERE Category = 'Furniture'
GROUP BY Sub_Category
ORDER BY [Profit Margin] DESC
;

-- Step 10 — SQL Interview Challenge

SELECT TOP 5
	Customer_Name,
	ROUND(SUM(SALES),2) AS [Total Sales]
FROM superstore
GROUP BY Customer_Name
ORDER BY [Total Sales] DESC
;

-- Step 11 — Slightly harder challenge

-- 11.1 Find the top 5 customers by total profit.

SELECT TOP 5
	Customer_Name,
	ROUND(SUM(Profit),2) AS [Total Profit]
FROM superstore
GROUP BY Customer_Name
ORDER BY [Total Profit] DESC
;

-- 11.2 Find the bottom 5 customers by total profit.

SELECT TOP 5
	Customer_Name,
	ROUND(SUM(Profit),2) AS [Total Profit]
FROM superstore
GROUP BY Customer_Name
ORDER BY [Total Profit]
;

-- Are our biggest customers necessarily our most profitable customers?
/* 
To solving this question, I'll work on two side of thinking
either from profit margin or by total sales or profit
*/
-- by profit margin
SELECT TOP 5
	Customer_Name,
	ROUND(SUM(SALES),2) AS [Total Sales],
	ROUND(SUM(PROFIT),2) AS [Total Profit],
	ROUND(SUM(PROFIT) / SUM(Sales) * 100, 2) AS [Profit Margin]
FROM superstore
GROUP BY Customer_Name
ORDER BY [Profit Margin] DESC
;
-- by total PROFIT

SELECT TOP 5
	Customer_Name,
	ROUND(SUM(Profit),2) AS [Total Profit]
FROM superstore
GROUP BY Customer_Name
ORDER BY [Total Profit]
;

-- BY TOTAL SALES
SELECT TOP 5
	Customer_Name,
	ROUND(SUM(SALES),2) AS [Total SALES]
FROM superstore
GROUP BY Customer_Name
ORDER BY [Total SALES]
;