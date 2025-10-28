-- See all the data imported:
SELECT * FROM blinkit_glosary; 

-- See specific column
SELECT 'item Fat Content' FROM blinkit_glosary;    

SELECT 'ï»¿Item Fat Content' FROM blinkit_glosary;

-- Change Specific column name
ALTER TABLE blinkit_glosary
CHANGE `ï»¿Item Fat Content`  Item_Fat_Content VARCHAR(50);   
 
 -- Data Cleaning
UPDATE blinkit_glosary
SET Item_Fat_Content = 
    CASE 
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

-- See cleaned data
SELECT item_fat_content FROM blinkit_glosary;

SELECT DISTINCT Item_Fat_Content FROM blinkit_glosary;

-- Change Specific column Name
ALTER TABLE blinkit_glosary
CHANGE `Total Sales`  Total_sales double;

-- See changed column name
SELECT Total_sales  from blinkit_glosary;

-- KPI'S 
-- 1. Total Sales 
SELECT CAST(SUM(Total_sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
FROM blinkit_glosary;

-- 2. Average Sales
SELECT CAST(AVG(Total_Sales) AS SIGNED) AS Avg_Sales
FROM blinkit_glosary;

-- 3. Number of Items
SELECT COUNT(*) AS No_of_Orders
FROM blinkit_glosary;

-- 4. Average Rating
SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating
FROM blinkit_glosary;

-- Total Sales by Fat content
SELECT Item_Fat_Content, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_glosary
GROUP BY Item_Fat_Content;

-- Change specific column name
ALTER TABLE blinkit_glosary
CHANGE `Item Type`  Item_type text;

-- Total sales by item type
SELECT Item_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_glosary
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

-- Change specific column name
ALTER TABLE blinkit_glosary
CHANGE `Outlet Location Type`  Outlet_Location_Type text;

-- Fat Content by Outlet for Total Sales
SELECT 
    Outlet_Location_Type,
    IFNULL(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales END), 0) AS Low_Fat,
    IFNULL(SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales END), 0) AS Regular
FROM blinkit_glosary
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;

-- Change specific column name
ALTER TABLE blinkit_glosary
CHANGE `Outlet Establishment Year`  Outlet_Establishment_Year int;

-- Total Sales by Outlet Establishment
SELECT Outlet_Establishment_Year, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_glosary
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;

-- Change specific column name
alter table blinkit_glosary
change `Outlet Size` Outlet_Size text;

-- Percentage of Sales by Outlet Size
SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
	FROM blinkit_glosary
	GROUP BY Outlet_Size
	ORDER BY Total_Sales DESC;

-- Total sales by outlet location type
SELECT Outlet_Location_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_glosary GROUP BY Outlet_Location_Type ORDER BY Total_Sales DESC;

-- change specific column name
ALTER TABLE blinkit_glosary CHANGE `Outlet Type` Outlet_Type  text;

ALTER TABLE blinkit_glosary
CHANGE `Item Visibility` Item_Visibility  double;

-- All Metrics by Outlet Type:
SELECT Outlet_Type , 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_glosary
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;


