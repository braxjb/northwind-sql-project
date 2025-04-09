-- 1. Show each order with customer and employee name

SELECT 
	o.OrderID, 
	c.CompanyName Customer,
	e.FirstName + ' ' +  e.LastName Employee,
	o.OrderDate
FROM Orders o 
	JOIN Customers c ON o.CustomerID = c.CustomerID
	JOIN Employees e ON o.EmployeeID = o.EmployeeID;

-- 2. List all products with their supplier and category

SELECT 
	p.ProductName,
	s.CompanyName Supplier,
	c.CategoryName
FROM Products p
	JOIN Suppliers s ON p.SupplierID = s.SupplierID
	JOIN Categories c ON p.CategoryID = c.CategoryID;

-- 3. Find orders that were shipped using 'Federal Shipping'

SELECT 
	o.OrderID, 
	o.OrderDate, 
	s.CompanyName AS Shipper
FROM Orders o
	JOIN Shippers s ON o.ShipVia = s.ShipperID
WHERE s.CompanyName = 'Federal Shipping';

-- 4. Count number of orders per customer

SELECT 
	c.CompanyName,
	COUNT( o.OrderID ) TotalOrders
FROM Customers c
	JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName
ORDER BY TotalOrders DESC;

-- 5. Total sales (revenue) per product
SELECT * FROM Products
SELECT * FROM [Order Details]

SELECT 
	p.ProductName,
	SUM(od.UnitPrice * od.Quantity) TotalRevenue
FROM Products p
	JOIN [Order Details] od ON  p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalRevenue DESC;

-- 6. Average quantity per product

SELECT 
	p.ProductName,
	AVG(od.Quantity) AverageQty
FROM Products p
	JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY AverageQty;

-- 7. Total revenue per category

SELECT
	c.CategoryName,
	SUM(od.UnitPrice * od.Quantity) Revenue
FROM Products p
	JOIN [Order Details] od ON p.ProductID = od.ProductID
	JOIN Categories c ON p.ProductID = od.ProductID
GROUP BY c.CategoryName
ORDER BY Revenue DESC;

-- 8. Customers who placed more than 5 orders

SELECT 
	c.CompanyName Customer,
	COUNT(o.OrderId) OrderCount
FROM Customers c
	JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName
HAVING COUNT(o.OrderId) > 5
ORDER BY OrderCount DESC;
