USE retail_superdatabase;
/* 
"Give us a high-level picture of how our business is performing and tell us where we should focus our attention."
*/

-- Task 8.1 — Executive KPIs
-- Total Sales
SELECT
ROUND(SUM(SALES),2) as [Total Sales]
FROM superstore;
-- Total Profit
SELECT
ROUND(SUM(Profit),2) as [Total Profit]
FROM superstore;
-- Profit Margin
SELECT
ROUND(SUM(Profit)/SUM(Sales)*100,2) as [Profit Margin]
FROM superstore;
-- Total Quantity
SELECT
	SUM(quantity) as [Total Quantity]
FROM superstore;
-- Total Unique Orders
SELECT
	 count( DISTINCT Order_ID) as [Total Orders]
FROM superstore;
-- Total Customers
SELECT
	count( DISTINCT Customer_ID) as [Total Customers]
FROM superstore;

--Task 8.2 — Category Performance 
SELECT
	Category,
	ROUND(SUM(SALES),2) as [Total Sales],
	ROUND(SUM(Profit),2) as [Total Profit],
	ROUND(SUM(Profit)/SUM(Sales)*100,2) as [Profit Margin],
	SUM(quantity) as [Total Quantity],
	count(Order_ID) as [Total Orders]
FROM superstore
GROUP BY
	Category
ORDER BY
	[Total Sales];

	-- Task 8.3 — Sub-Category Investigation

SELECT
	Category,
	Sub_Category,
	ROUND(SUM(SALES),2) as [Total Sales],
	ROUND(SUM(Profit),2) as [Total Profit],
	ROUND(SUM(Profit)/SUM(Sales)*100,2) as [Profit Margin],
	SUM(quantity) as [Total Quantity],
	count(Order_ID) as [Total Orders]
FROM superstore
GROUP BY
	Category,
	Sub_Category
Having 
	SUM(Profit) < 0
ORDER BY
	[Total Profit] ;

-- TASK 8.4 — Region
SELECT
	Region,
	ROUND(SUM(SALES),2) as [Total Sales],
	ROUND(SUM(Profit),2) as [Total Profit],
	ROUND(SUM(Profit)/SUM(Sales)*100,2) as [Profit Margin],
	SUM(quantity) as [Total Quantity],
	count(Order_ID) as [Total Orders]
FROM superstore
GROUP BY
	Region
ORDER BY
	[Total Profit] ;

-- Task 8.5 — Discount Investigation

SELECT
	round(discount,2)AS Discount,
	ROUND(SUM(SALES),2) as [Total Sales],
	ROUND(SUM(Profit),2) as [Total Profit],
	ROUND(SUM(Profit)/SUM(Sales)*100,2) as [Profit Margin],
	SUM(quantity) as [Total Quantity],
	count(Order_ID) as [Total Orders]
FROM superstore
GROUP BY
	round(discount,2)
ORDER BY
	[Total Profit] ;