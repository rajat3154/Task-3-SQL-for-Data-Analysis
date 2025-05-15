-- analysis.sql - SQL for Data Analysis on Ecommerce Dataset

-- Create and use the database\CREATE DATABASE demo;
USE demo;

-- Create Customers table to store customer info
CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    join_date DATE
);

-- Create Orders table with reference to Customers
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    total_amount FLOAT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create Products table to store product info
CREATE TABLE Products (
    product_id INTEGER PRIMARY KEY,
    name TEXT,
    price FLOAT,
    category TEXT
);

-- Create OrderDetails to track product quantities per order
CREATE TABLE OrderDetails (
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- View all customers
SELECT * FROM Customers;

-- Filter orders with total amount greater than 500
SELECT * FROM Orders
WHERE total_amount > 500;

-- Sort products by price descending
SELECT * FROM Products
ORDER BY price DESC;

-- Calculate total sales grouped by product category
SELECT p.category, SUM(p.price * od.quantity) AS total_sales
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.category;

-- Join Orders with Customers to display order and customer info
SELECT o.order_id, c.name AS customer_name, o.order_date, o.total_amount
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id;

-- Insert sample data into Customers
INSERT INTO Customers VALUES (1, 'Alice', 'alice@gmail.com', '2023-01-01');
INSERT INTO Customers VALUES (2, 'Bob', 'bob@gmail.com', '2023-02-01');
INSERT INTO Customers VALUES (3, 'Charlie', 'charlie@gmail.com', '2023-03-01');

-- Insert sample Products
INSERT INTO Products VALUES (101, 'Laptop', 800.00, 'Electronics');
INSERT INTO Products VALUES (102, 'Mouse', 25.00, 'Electronics');
INSERT INTO Products VALUES (103, 'Book', 10.00, 'Stationery');

-- Insert sample Orders
INSERT INTO Orders VALUES (201, 1, '2023-04-01', 825.00);
INSERT INTO Orders VALUES (202, 2, '2023-04-05', 10.00);

-- Insert Order Details
INSERT INTO OrderDetails VALUES (201, 101, 1);
INSERT INTO OrderDetails VALUES (201, 102, 1);
INSERT INTO OrderDetails VALUES (202, 103, 1);

-- List products in each order
SELECT od.order_id, p.name AS product_name, od.quantity
FROM OrderDetails od
INNER JOIN Products p ON od.product_id = p.product_id;

-- LEFT JOIN to show all customers even if they haven’t ordered
SELECT c.name, o.order_id, o.order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- Subquery to get names of customers with orders > 500
SELECT name FROM Customers
WHERE customer_id IN (
    SELECT customer_id FROM Orders WHERE total_amount > 500
);

-- Group by to get average order amount per customer
SELECT customer_id, AVG(total_amount) AS avg_order_amount
FROM Orders
GROUP BY customer_id;

-- Total quantity sold for each product
SELECT p.name, SUM(od.quantity) AS total_quantity_sold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id;


