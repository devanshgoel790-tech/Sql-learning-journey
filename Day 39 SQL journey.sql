CREATE DATABASE IF NOT EXISTS case_practice;
USE case_practice;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    category VARCHAR(30),
    quantity INT,
    unit_price DECIMAL(10, 2),
    status VARCHAR(20)
);
INSERT INTO orders
    (order_id, customer_name, product, category, quantity, unit_price, status)
VALUES
    (1, 'Asha',  'Laptop',    'Electronics', 1, 750.00, 'Delivered'),
    (2, 'Ravi',  'Headphones','Electronics', 2,  45.00, 'Pending'),
    (3, 'Maya',  'Desk',      'Furniture',   1, 180.00, 'Delivered'),
    (4, 'Noah',  'Chair',     'Furniture',   4,  65.00, 'Cancelled'),
    (5, 'Asha',  'Mouse',     'Electronics', 3,  20.00, 'Delivered'),
    (6, 'Liam',  'Notebook',  'Stationery', 10,   3.50, 'Pending'),
    (7, 'Ravi',  'Monitor',   'Electronics', 2, 220.00, 'Delivered'),
    (8, 'Maya',  'Pen',       'Stationery', 5,   2.00, 'Cancelled'),
    (9, 'Noah',  'Bookshelf', 'Furniture',   1, 130.00, 'Pending'),
    (10,'Liam',  'Keyboard',  'Electronics', 1,  55.00, 'Delivered');

SELECT * FROM orders;

SELECT
    order_id,
    product,
    quantity * unit_price AS order_total,
    CASE
        WHEN quantity * unit_price >= 200 THEN 'High value'
        ELSE 'Standard'
    END AS value_label
FROM orders;

SELECT
    order_id,
    customer_name,
    status,
    CASE status
        WHEN 'Delivered' THEN 'Shipped successfully'
        WHEN 'Pending'   THEN 'Being processed'
        WHEN 'Cancelled' THEN 'Order cancelled'
        ELSE 'Unknown status'
    END AS shipping_message
FROM orders;


SELECT
    order_id,
    product,
    quantity,
    CASE
        WHEN quantity = 1 THEN 'Small'
        WHEN quantity BETWEEN 2 AND 4 THEN 'Medium'
        WHEN quantity >= 5 THEN 'Large'
        ELSE 'Unknown'
    END AS quantity_group
FROM orders;


SELECT
    order_id,
    product,
    category,
    quantity * unit_price AS original_total,
    CASE
        WHEN category = 'Electronics' THEN quantity * unit_price * 0.10
        WHEN category = 'Furniture'   THEN quantity * unit_price * 0.05
        ELSE 0
    END AS discount_amount,
    quantity * unit_price -
    CASE
        WHEN category = 'Electronics' THEN quantity * unit_price * 0.10
        WHEN category = 'Furniture'   THEN quantity * unit_price * 0.05
        ELSE 0
    END AS final_total
FROM orders;

SELECT
    product,
    category,
    CASE category
        WHEN 'Electronics' THEN 'Tech'
        WHEN 'Furniture' THEN 'Home'
        ELSE 'Other'
    END AS category_label
FROM orders;