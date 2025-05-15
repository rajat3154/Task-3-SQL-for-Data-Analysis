-- analysis.sql - SQL for Data Analysis on Ecommerce Dataset

-- 1. View all orders
SELECT * FROM orders;

-- 2. Total revenue
SELECT SUM(total_amount) AS total_revenue FROM orders;

-- 3. Top 5 selling products by quantity
SELECT p.product_id, p.product_name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC
LIMIT 5;

-- 4. Average order value per customer
SELECT c.customer_id, c.customer_name, AVG(o.total_amount) AS avg_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY avg_order_value DESC;

-- 5. Number of orders per month
SELECT strftime('%Y-%m', order_date) AS month, COUNT(*) AS order_count
FROM orders
GROUP BY month
ORDER BY month;

-- 6. Customers who ordered more than 5 times
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING total_orders > 5;

-- 7. Revenue by category
SELECT c.category_name, SUM(oi.quantity * oi.price) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY category_revenue DESC;

-- 8. Products that have never been ordered
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;

-- 9. Most frequent customer
SELECT o.customer_id, c.customer_name, COUNT(*) AS order_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id
ORDER BY order_count DESC
LIMIT 1;

-- 10. Orders with total above average
SELECT *
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders);

-- 11. Create view for monthly revenue
CREATE VIEW monthly_revenue AS
SELECT strftime('%Y-%m', order_date) AS month, SUM(total_amount) AS revenue
FROM orders
GROUP BY month;

-- 12. Create index to speed up order search by customer
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
