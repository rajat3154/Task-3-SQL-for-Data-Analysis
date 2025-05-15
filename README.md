# Task-3-SQL-for-Data-Analysis
# 📊 Task 3: SQL for Data Analysis

## 🧠 Objective
This project demonstrates how SQL can be used to perform data analysis on an E-commerce dataset. It includes creating and populating tables, retrieving meaningful insights using various SQL queries, and optimizing performance using indexes and views.

---

## 🛠️ Tools Used

- **SQL Engine**: MySQL 
- **IDE/Editor**: MySQL Workbench
- **Version Control**: Git & GitHub

---

## 🗂️ Database Schema

The project consists of the following relational tables:

### 🧍 Customers
```sql
customer_id INTEGER PRIMARY KEY,
name TEXT,
email TEXT,
join_date DATE
```

### 📦 Orders
```sql
order_id INTEGER PRIMARY KEY,
customer_id INTEGER,
order_date DATE,
total_amount FLOAT,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
```

### 🛒 Products
```sql
product_id INTEGER PRIMARY KEY,
name TEXT,
price FLOAT,
category TEXT
```

### 📋 OrderDetails
```sql
order_id INTEGER,
product_id INTEGER,
quantity INTEGER,
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id)
```

---

## 📥 Data Insertion

Sample data is inserted into each table for testing and analysis, including:

- 3 Customers (e.g., Alice, Bob, Charlie)
- 3 Products (Laptop, Mouse, Book)
- 2 Orders (with varying total amounts)
- Related OrderDetails for each order

---

## 🔍 Key SQL Queries & Features

### ✅ Basic Queries
- View all customers  
  ```sql
  SELECT * FROM Customers;
  ```

- Filter orders with total amount > ₹500  
  ```sql
  SELECT * FROM Orders WHERE total_amount > 500;
  ```

- Sort products by price (high to low)  
  ```sql
  SELECT * FROM Products ORDER BY price DESC;
  ```

---

### 📈 Aggregations
- Total sales by product category  
  ```sql
  SELECT p.category, SUM(p.price * od.quantity) AS total_sales
  FROM Products p
  JOIN OrderDetails od ON p.product_id = od.product_id
  GROUP BY p.category;
  ```

- Average order amount per customer  
  ```sql
  SELECT customer_id, AVG(total_amount) AS avg_order_amount
  FROM Orders
  GROUP BY customer_id;
  ```

- Total quantity sold for each product  
  ```sql
  SELECT p.name, SUM(od.quantity) AS total_quantity_sold
  FROM Products p
  JOIN OrderDetails od ON p.product_id = od.product_id
  GROUP BY p.product_id;
  ```

---

### 🔗 Joins & Subqueries
- Join Orders with Customers to display order details  
  ```sql
  SELECT o.order_id, c.name AS customer_name, o.order_date, o.total_amount
  FROM Orders o
  INNER JOIN Customers c ON o.customer_id = c.customer_id;
  ```

- LEFT JOIN to show all customers, even those with no orders  
  ```sql
  SELECT c.name, o.order_id, o.order_date
  FROM Customers c
  LEFT JOIN Orders o ON c.customer_id = o.customer_id;
  ```

- Subquery: Get names of customers who made orders > ₹500  
  ```sql
  SELECT name FROM Customers
  WHERE customer_id IN (
    SELECT customer_id FROM Orders WHERE total_amount > 500
  );
  ```

---

### 📄 Views
- View: Total units sold per product  
  ```sql
  CREATE VIEW ProductSales AS
  SELECT p.product_id, p.name AS product_name, SUM(od.quantity) AS total_sold
  FROM Products p
  JOIN OrderDetails od ON p.product_id = od.product_id
  GROUP BY p.product_id;
  ```

- View: Customer order summary  
  ```sql
  CREATE VIEW CustomerOrderSummary AS
  SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders, AVG(o.total_amount) AS avg_order_value
  FROM Customers c
  LEFT JOIN Orders o ON c.customer_id = o.customer_id
  GROUP BY c.customer_id;
  ```

---

### 🚀 Performance Optimization
- Index to speed up lookups by customer in Orders  
  ```sql
  CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
  ```

- Index to speed up lookups by product in OrderDetails  
  ```sql
  CREATE INDEX idx_orderdetails_product_id ON OrderDetails(product_id);
  ```

---

## 📌 Output Snapshots

> Include screenshots of your database output, query results, and view contents if required by the submission guidelines.

---

## ✅ Conclusion
This project successfully demonstrates the practical use of SQL for data analysis, covering database schema design, query formulation, data aggregation, view creation, and indexing.

---

## 🔗 GitHub Repository
[👉 Click to view the project](https://github.com/rajat3154/Task-3-SQL-for-Data-Analysis)

---

