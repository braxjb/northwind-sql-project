-- 1. Find customers who placed more orders than the average

SELECT 
	CustomerID, 
	COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > (
    SELECT AVG(OrderCount) FROM (
        SELECT CustomerID, COUNT(OrderID) AS OrderCount
        FROM Orders
        GROUP BY CustomerID
    ) AS Sub
);


-- 2. Show products that have a unit price above the average


SELECT 
	ProductName,
	UnitPrice
FROM Products
WHERE UnitPrice > (
    SELECT AVG(UnitPrice) FROM Products
);

-- 3. Get all employees who handled more than 100 orders


SELECT
	e.employeeID,
	e.FirstName,
	e.LastName,
	COUNT(o.OrderID) AS OrdersHandled
FROM Employees e
	JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY 
	e.employeeID,
	e.FirstName,
	e.LastName
ORDER BY OrdersHandled DESC;


-- 4. Use CTE to get top 5 customers by order count


WITH CustomerOrderCounts AS (
    SELECT CustomerID, COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY CustomerID
)
SELECT TOP 5 CustomerID, OrderCount
FROM CustomerOrderCounts
ORDER BY OrderCount DESC;


-- 5. Use CTE to get total revenue per category


WITH RevenuePerCategory AS (
	SELECT 
		c.CategoryName,
		SUM(od.UnitPrice * od.Quantity) Revenue
	FROM Categories c
		JOIN Products p ON c.CategoryID = p.CategoryID
		JOIN [Order Details] od ON p.ProductID = od.ProductID
	GROUP BY c.CategoryName
)
SELECT * FROM RevenuePerCategory
ORDER BY Revenue DESC;


-- 6. CTE for average order value per customer


WITH OrderValues AS (
    SELECT 
		o.OrderID, 
		o.CustomerID, 
		SUM(od.UnitPrice * od.Quantity) AS OrderValue
    FROM Orders o
		JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY 
		o.OrderID, 
		o.CustomerID
)
SELECT 
	CustomerID, 
	AVG(OrderValue) AS AvgOrderValue
FROM OrderValues
GROUP BY CustomerID
ORDER BY AvgOrderValue DESC;
