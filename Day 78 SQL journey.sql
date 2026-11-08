CREATE DATABASE IF NOT EXISTS retail_sales_db;
USE retail_sales_db;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS reps;

CREATE TABLE reps (
  rep_id     INT PRIMARY KEY,
  rep_name   VARCHAR(30),
  manager_id INT
);

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name        VARCHAR(30),
  city        VARCHAR(20),
  rep_id      INT
);

CREATE TABLE products (
  product_id   INT PRIMARY KEY,
  product_name VARCHAR(30),
  category     VARCHAR(20),
  price        INT
);

CREATE TABLE orders (
  order_id    INT PRIMARY KEY,
  customer_id INT,
  order_date  DATE,
  status      VARCHAR(15)
);

CREATE TABLE order_items (
  item_id    INT PRIMARY KEY,
  order_id   INT,
  product_id INT,
  quantity   INT
);

INSERT INTO reps VALUES
(1, 'Anil Kapoor',  NULL),
(2, 'Bina Rao',     1),
(3, 'Chetan Shah',  1),
(4, 'Dipti Nair',   2),
(5, 'Esha Jain',    2),
(6, 'Farhan Ali',   3);

INSERT INTO customers VALUES
(1, 'Aarav Mehta', 'Delhi',  4),
(2, 'Riya Das',    'Mumbai', 5),
(3, 'Kabir Singh', 'Pune',   6),
(4, 'Maya Shah',   'Jaipur', 4),
(5, 'Noah Patel',  'Delhi',  5),
(6, 'Zoya Khan',   'Mumbai', 6),
(7, 'Isha Rao',    'Pune',   4),
(8, 'Arjun Nair',  'Jaipur', 5);

INSERT INTO products VALUES
(1, 'Laptop',   'Electronics', 55000),
(2, 'Phone',    'Electronics', 30000),
(3, 'Desk',     'Furniture',   12000),
(4, 'Chair',    'Furniture',    6000),
(5, 'Notebook', 'Stationery',    150),
(6, 'Pen Set',  'Stationery',    400);

INSERT INTO orders VALUES
(1001, 1, '2026-08-03', 'Delivered'),
(1002, 1, '2026-08-20', 'Delivered'),
(1003, 2, '2026-08-11', 'Delivered'),
(1004, 3, '2026-08-25', 'Cancelled'),
(1005, 3, '2026-09-02', 'Delivered'),
(1006, 4, '2026-09-09', 'Shipped'),
(1007, 5, '2026-09-15', 'Delivered'),
(1008, 2, '2026-09-21', 'Delivered'),
(1009, 6, '2026-10-01', 'Shipped'),
(1010, 1, '2026-10-05', 'Delivered'),
(1011, 4, '2026-10-12', 'Delivered'),
(1012, 5, '2026-10-18', 'Cancelled'),
(1013, 6, '2026-10-22', 'Delivered'),
(1014, 3, '2026-10-28', 'Shipped');

INSERT INTO order_items VALUES
(1,  1001, 1, 1),
(2,  1001, 5, 10),
(3,  1002, 2, 2),
(4,  1003, 3, 1),
(5,  1003, 4, 2),
(6,  1004, 1, 1),
(7,  1005, 2, 1),
(8,  1005, 5, 20),
(9,  1006, 3, 2),
(10, 1007, 4, 4),
(11, 1007, 5, 5),
(12, 1008, 1, 1),
(13, 1008, 3, 1),
(14, 1009, 2, 3),
(15, 1010, 4, 2),
(16, 1011, 1, 1),
(17, 1011, 2, 1),
(18, 1012, 3, 1),
(19, 1013, 5, 15),
(20, 1013, 4, 1),
(21, 1014, 2, 2),
(22, 1014, 5, 8);

SELECT * FROM customers;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM reps;

SELECT o.order_id, 
	   c.name,
       o.order_date
FROM  orders o
INNER JOIN customers c 
ON o.customer_id = c.customer_id;

SELECT c.name, 
       o.order_id
FROM customers c
LEFT JOIN orders o
ON o.customer_id = c.customer_id
WHERE status = "Delivered" ;
 
 SELECT c.name,
       COUNT(o.order_id) as number_of_orders
FROM customers c
LEFT JOIN orders o
ON o.customer_id = c.customer_id
GROUP BY  c.name;

SELECT c.name
FROM customers c
LEFT JOIN orders o
ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

SELECT p.product_name,
       COUNT(oi.order_id)as number_of_lines
 FROM order_items oi
 RIGHT JOIN products p
 ON p.product_id = oi.product_id 
 GROUP BY p.product_name;
 
SELECT oi.order_id,
       c.name,
       p.product_name,
       oi.quantity
FROM order_items oi
INNER JOIN orders o
ON oi.order_id = o.order_id
INNER JOIN customers c
ON o.customer_id = c.customer_id 
INNER JOIN products p 
ON oi.product_id = p.product_id ;

SELECT c.name, 
	  SUM(oi.quantity * p.price) as total_sales_amount
FROM order_items oi
INNER JOIN orders o
ON oi.order_id = o.order_id 
INNER JOIN customers c
ON o.customer_id = c.customer_id 
INNER JOIN products p 
ON oi.product_id = p.product_id 
where o.status  <> "Cancelled"
GROUP BY c.name
ORDER BY  SUM(oi.quantity * p.price) DESC;

SELECT p.category, 
	  SUM(oi.quantity * p.price) as total_sales_amount
FROM order_items oi
INNER JOIN orders o
ON oi.order_id = o.order_id 
INNER JOIN customers c
ON o.customer_id = c.customer_id 
INNER JOIN products p 
ON oi.product_id = p.product_id 
where o.status <> "Cancelled"
GROUP BY p.category
HAVING  SUM(oi.quantity * p.price) > 100000;

WITH customer_sales AS (
    SELECT c.name, SUM(oi.quantity * p.price) AS total_sales
    FROM orders o
   INNER JOIN customers c ON o.customer_id = c.customer_id
   INNER JOIN order_items oi ON o.order_id = oi.order_id
    INNER JOIN products p ON oi.product_id = p.product_id
    WHERE o.status <> 'Cancelled'
    GROUP BY c.customer_id, c.name
)
SELECT name, total_sales,
       RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM customer_sales;

SELECT 
    r.rep_name AS representative_name,
    m.rep_name AS manager_name
FROM reps r
LEFT JOIN reps m ON r.manager_id = m.rep_id;



       
SELECT * FROM customers;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM reps;    
