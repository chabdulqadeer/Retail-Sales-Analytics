USE retail_superdatabase;
/* 
"How has our business performed over time? 
Are sales and profit improving, and are there periods where revenue growth is not translating into profitability?"
*/

-- Task 9.1 — Yearly Performance
SELECT
	YEAR(Order_Date) AS Year,
	ROUND(SUM(SALES),2) AS [Total Sales],
	ROUND(SUM(Profit),2) AS [Total Profit],
	ROUND(SUM(Profit)/SUM(SALES) * 100,2) AS [Profit Margins],
	SUM(Quantity) as [Total Quantity],
	COUNT(DISTINCT Order_ID) AS [Total No.of Orders],
	COUNT( DISTINCT CUSTOMER_ID) AS [Unique Customers]
FROM superstore
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date) DESC
;

-- Task 9.2 — Year-over-Year Growth

WITH SALES_GROWTH AS (
	SELECT
		YEAR(Order_Date) AS Year,
		ROUND(SUM(SALES),2) AS [Total Sales],
		LAG(ROUND(SUM(SALES),2)) OVER(ORDER BY YEAR(Order_Date)) AS [Previous Year Sales],
		ROUND(SUM(Profit),2) AS [Total Profit],
		LAG(ROUND(SUM(Profit),2)) OVER(ORDER BY YEAR(Order_Date)) AS [Previous Year Profit],
		ROUND(SUM(Profit)/SUM(SALES) * 100,2) AS [Profit Margins]
	FROM superstore
	GROUP BY YEAR(Order_Date)
)
	SELECT
		Year,
		[Total Sales],
		[Previous Year Sales],
		ROUND(([Total Sales] - [Previous Year Sales])/[Previous Year Sales] * 100,2) AS [Yearly Sales Growth],
		[Total Profit],
		[Previous Year Profit],
		ROUND(([Total Profit] - [Previous Year Profit])/[Previous Year Profit] * 100,2) AS [Yearly Profit Growth]
	FROM SALES_GROWTH
	ORDER BY Year
	;

-- Task 9.3 — Monthly Sales Trend 📈

SELECT
	YEAR(Order_Date) AS Year,
	MONTH(Order_Date) AS Month,
	ROUND(SUM(SALES),2) AS [Total Sales],
	ROUND(SUM(Profit),2) AS [Total Profit],
	ROUND(SUM(Profit)/SUM(SALES) * 100,2) AS [Profit Margins],
	COUNT( DISTINCT CUSTOMER_ID) AS [Unique Customers]
FROM superstore
GROUP BY YEAR(Order_Date),MONTH(Order_Date)
ORDER BY YEAR(Order_Date) DESC, MONTH(Order_Date) ASC
;

-- Task 9.5 — Monthly Profitability Investigation
SELECT TOP 5
	YEAR(Order_Date) AS Year,
	MONTH(Order_Date) AS Month,
	ROUND(SUM(SALES),2) AS [Total Sales],
	ROUND(SUM(Profit),2) AS [Total Profit],
	ROUND(SUM(Profit)/SUM(SALES) * 100,2) AS [Profit Margins]
FROM superstore
GROUP BY YEAR(Order_Date),MONTH(Order_Date)
ORDER BY [Total Profit] ASC
;
