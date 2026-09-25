
 CREATE DATABASE IF NOT EXISTS portfolio_practice;
USE portfolio_practice;

 CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_amount DECIMAL(10, 2),
    shipping_days INT,                                                                                                                                                                                                                                                                                                                                                          
    order_status VARCHAR(20)
    
);
INSERT INTO orders (order_id, customer_name, order_amount, shipping_days, order_status) VALUES
(101, 'Rahul Sharma', 1500.50, 2, 'Delivered'),
(102, 'Priya Patel', 45.00, 7, 'Delivered'),
(103, 'Amit Verma', 3200.00, 1, 'Processing'),
(104, 'Sneha Reddy', 890.25, 5, 'Cancelled'),
(105, 'Vikram Singh', 120.00, 12, 'Delivered'),
(106, 'Ananya Das', 5200.00, 3, 'Processing'),
(107, 'Rohan Malhotra', 35.50, 9, 'Delivered'),
(108, 'Kriti Joshi', 2450.00, 4, 'Cancelled');

SELECT
    order_id,
    order_amount,
    CASE 
        WHEN order_amount < 50.00 THEN 'Small Order'
        WHEN order_amount >= 50.00 AND order_amount <= 500.00 THEN 'Medium Order'
        ELSE 'Large Order'
    END AS order_tier
    FROM orders;
    

SELECT
    order_id,
    order_status,
    CASE order_status
        WHEN 'Delivered' THEN 'Completed'
        WHEN 'Processing' THEN 'Active'
        ELSE 'Requires Attention'
    END AS internal_status_label
    FROM orders;
    
SELECT
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN order_status = 'Delivered' THEN 1 END) AS completed_orders_count,
    COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) AS cancelled_orders_count
    FROM orders;

