-- Northwind SQL Dashboard Summary
-- This file brings together key business metrics and insights

-- 1. Top 5 Customers by Total Revenue


SELECT TOP 5 
	c.CompanyName, 
	SUM(od.UnitPrice * od.Quantity) AS TotalRevenue
FROM Customers c
	JOIN Orders o ON c.CustomerID = o.CustomerID
	JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
ORDER BY TotalRevenue DESC;


-- 2. Best-Selling Products by Quantity


SELECT TOP 5 
	p.ProductName, 
	SUM(od.Quantity) AS TotalSold
FROM Products p
	JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalSold DESC;


-- 3. Revenue by Category


SELECT 
	c.CategoryName, 
	SUM(od.UnitPrice * od.Quantity) AS Revenue
FROM Categories c
	JOIN Products p ON c.CategoryID = p.CategoryID
	JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY c.CategoryName
ORDER BY Revenue DESC;


-- 4. Orders by Country


SELECT 
	Country, 
	COUNT(OrderID) AS OrderCount
FROM Customers c
	JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY Country
ORDER BY OrderCount DESC;


-- 5. Average Order Value per Customer


WITH OrderValues AS (
    SELECT 
		o.CustomerID, 
		o.OrderID, 
		SUM(od.UnitPrice * od.Quantity) AS OrderValue
    FROM Orders o
		JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID, o.OrderID
)
SELECT 
	CustomerID, 
	AVG(OrderValue) AS AvgOrderValue
FROM OrderValues
GROUP BY CustomerID
ORDER BY AvgOrderValue DESC;


-- 6. Top Employees by Orders Handled


SELECT 
	e.FirstName + ' ' + e.LastName AS EmployeeName, 
	COUNT(o.OrderID) AS OrdersHandled
FROM Employees e
	JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName, e.LastName
ORDER BY OrdersHandled DESC;
