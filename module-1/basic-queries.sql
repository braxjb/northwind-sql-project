-- List all tables
SELECT * 
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- View structure of a specific table (e.g., Customers)
EXEC sp_help 'Customers';
EXEC sp_help 'Orders';
EXEC sp_help 'Employees';
EXEC sp_help 'Products';

-- 1. Get all customers
SELECT * 
FROM Customers;

-- 2. List all products and sort by unit price
SELECT * 
FROM Products 
ORDER BY UnitPrice DESC;

-- 3. Get unique cities where customers are located
SELECT DISTINCT City
FROM Customers;

-- 4. Get all orders from 1997
SELECT * 
FROM Orders
WHERE YEAR(OrderDate) = 1997;

-- 5. Top 10 most expensive products
SELECT TOP 10 
UnitPrice,
ProductName
FROM PRODUCTS
ORDER BY UnitPrice;

