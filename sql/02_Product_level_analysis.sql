USE retail_superdatabase;
-- Product-level analysis
-- 1. Top 10 products by Sales
SELECT TOP 10
	Product_Name,
	ROUND(SUM(SALES),2) AS [Total Sales],
	ROUND(SUM(PROFIT),2) AS [Total Profit],
	ROUND(SUM(PROFIT) / SUM(SALES) * 100, 2) AS [Profit Margin],
	SUM(QUANTITY) AS [Total Qunatity],
	COUNT(Row_ID) as [Number of Orders]
FROM superstore
GROUP BY Product_Name
ORDER BY [Total Sales] DESC;

SELECT TOP 10
	Product_Name,
	ROUND(SUM(SALES),2) AS [Total Sales],
	ROUND(SUM(PROFIT),2) AS [Total Profit],
	ROUND(SUM(PROFIT) / SUM(SALES) * 100, 2) AS [Profit Margin],
	SUM(QUANTITY) AS [Total Qunatity],
	COUNT(Row_ID) as [Number of Orders]
FROM superstore
GROUP BY Product_Name
ORDER BY [Total Profit];
-- 2. Among those 10 products, which ones are actually generating a loss?
WITH LOSS_PRODUCT AS (
SELECT TOP 10
	Product_Name,
	ROUND(SUM(SALES),2) AS [Total Sales],
	ROUND(SUM(PROFIT),2) AS [Total Profit],
	ROUND(SUM(PROFIT) / SUM(SALES) * 100, 2) AS [Profit Margin],
	SUM(QUANTITY) AS [Total Qunatity],
	COUNT(Row_ID) as [Number of Orders]
FROM superstore
GROUP BY Product_Name
ORDER BY [Total Sales] DESC)
	SELECT 
		Product_Name,
		[Total Sales],
		[Total Profit],
		[Profit Margin],
		[Total Qunatity],
		[Number of Orders]
	FROM LOSS_PRODUCT
	WHERE [Profit Margin] < 0
;

-- Which product has the highest Sales but negative Profit?

WITH LOSS_PRODUCT AS (
SELECT
	Product_Name,
	Category,
	Sub_Category,
	ROUND(SUM(SALES),2) AS [Total Sales],
	ROUND(SUM(PROFIT),2) AS [Total Profit],
	ROUND(SUM(PROFIT) / SUM(SALES) * 100, 2) AS [Profit Margin],
	SUM(QUANTITY) AS [Total Qunatity],
	COUNT(Row_ID) as [Number of Orders]
FROM superstore
GROUP BY 
	Product_Name,
	Category,
	Sub_Category)
	SELECT TOP 10
		Product_Name,
		Category,
		Sub_Category,
		[Total Sales],
		[Total Profit],
		[Profit Margin],
		[Total Qunatity],
		[Number of Orders]
	FROM LOSS_PRODUCT
	WHERE [Total Profit] < 0
	ORDER BY [Total Sales] DESC
	;


SELECT
	Category,
	Sub_Category,
	ROUND(SUM(SALES),2) AS [Total Sales],
	ROUND(SUM(PROFIT),2) AS [Total Profit],
	ROUND(SUM(PROFIT) / SUM(SALES) * 100, 2) AS [Profit Margin],
	ROUND(AVG(Discount),2) AS [Average Discount],
	SUM(QUANTITY) AS [Total Qunatity],
	COUNT(Row_ID) as [Number of Orders]
FROM superstore
GROUP BY
	Category,
	Sub_Category
ORDER BY
	[Profit Margin]
;
