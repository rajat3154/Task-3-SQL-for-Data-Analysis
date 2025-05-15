-- View showing total units sold per product
CREATE VIEW ProductSales AS
SELECT p.product_id, p.name AS product_name, SUM(od.quantity) AS total_sold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id;

-- Query ProductSales view ordered by total sold
SELECT * FROM ProductSales ORDER BY total_sold DESC;

-- View for customer order summary with average order value
CREATE VIEW CustomerOrderSummary AS
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders, AVG(o.total_amount) AS avg_order_value
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- Filter customers with high average order value
SELECT * FROM CustomerOrderSummary WHERE avg_order_value > 500;

-- Index to optimize lookups by customer in Orders
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);

-- Index to optimize lookups by product in OrderDetails
CREATE INDEX idx_orderdetails_product_id ON OrderDetails(product_id);