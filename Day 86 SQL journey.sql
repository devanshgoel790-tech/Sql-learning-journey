CREATE DATABASE IF NOT EXISTS retail_norm_v2_db;
USE retail_norm_v2_db;

CREATE TABLE orders_flat (
  order_id INT PRIMARY KEY,
  customer_name VARCHAR(20), 
  city VARCHAR(20),
  product_name VARCHAR(20), 
  category VARCHAR(20), 
  unit_price INT, 
  qty INT, 
  order_date DATE
);
INSERT INTO orders_flat VALUES
(1,'Rahul','Meerut','Pen','Stationery',10,10,'2026-10-02'),
(2,'Rahul','Meerut','Bag','Accessories',600,1,'2026-10-02'),
(3,'Sana','Delhi','Notebook','Stationery',50,4,'2026-10-05'),
(4,'Sana','Delhi','Bottle','Accessories',250,2,'2026-10-09'),
(5,'Vivek','Noida','Lamp','Electronics',800,1,'2026-10-12'),
(6,'Vivek','Noida','Pen','Stationery',10,20,'2026-10-12'),
(7,'Meena','Meerut','Bag','Accessories',600,2,'2026-10-15'),
(8,'Meena','Meerut','Notebook','Stationery',50,6,'2026-10-20'),
(9,'Anil','Delhi','Bottle','Accessories',250,4,'2026-10-21'),
(10,'Anil','Delhi','Lamp','Electronics',800,1,'2026-10-25'),
(11,'Rahul','Meerut','Lamp','Electronics',800,1,'2026-11-03'),
(12,'Sana','Delhi','Bag','Accessories',600,1,'2026-11-05');

CREATE TABLE stock (product_name VARCHAR(20) PRIMARY KEY, qty_in_stock INT);
INSERT INTO stock VALUES 
('Pen',100),
('Notebook',80),
('Bag',40),
('Bottle',60),
('Lamp',25);

CREATE TABLE orders_head (order_id INT PRIMARY KEY, customer_name VARCHAR(20), order_date DATE);
INSERT INTO orders_head VALUES 
(1,'Rahul','2026-10-02'),
(2,'Sana','2026-10-05'),
(3,'Vivek','2026-10-12'),
(4,'Meena','2026-10-15');

CREATE TABLE order_items (
  item_id INT PRIMARY KEY, 
  order_id INT, 
  product_name VARCHAR(20),
  FOREIGN KEY (order_id) REFERENCES orders_head(order_id) ON DELETE CASCADE
);
INSERT INTO order_items VALUES
(1,1,'Pen'),
(2,1,'Bag'),
(3,2,'Notebook'),
(4,2,'Bottle'),
(5,3,'Lamp'),
(6,3,'Pen'),
(7,4,'Bag'),
(8,4,'Notebook');

SELECT * FROM order_items;
SELECT * FROM orders_flat;
SELECT * FROM orders_head;
SELECT * FROM stock;

CREATE TABLE cities AS SELECT DISTINCT city FROM orders_flat;
SELECT * FROM cities ORDER BY city;

CREATE TABLE order_lines AS
SELECT order_id, customer_name, product_name, qty FROM orders_flat;

SELECT * FROM order_lines WHERE qty >= 4 ORDER BY order_id;

START TRANSACTION;
INSERT INTO stock VALUES ('Eraser', 200);
UPDATE stock SET qty_in_stock = qty_in_stock - 10 WHERE product_name = 'Bag';
COMMIT;

SELECT * FROM stock ORDER BY qty_in_stock DESC;

START TRANSACTION;
DELETE FROM stock WHERE qty_in_stock < 50;
ROLLBACK;

SELECT COUNT(*) FROM stock;

DELETE FROM orders_head WHERE order_id = 2;
SELECT COUNT(*) FROM order_items;

INSERT INTO order_items VALUES (9, 2, 'Pen');

CREATE INDEX idx_flat_city ON orders_flat(city);

SELECT order_id,
       unit_price * qty AS order_value,
       CASE WHEN unit_price * qty >= 800 THEN 'Large'
            WHEN unit_price * qty >= 300 THEN 'Medium'
            ELSE 'Small' END AS size
FROM orders_flat
ORDER BY order_id;

SELECT customer_name,
       SUM(unit_price * qty) AS total_spend,
       RANK() OVER (ORDER BY SUM(unit_price * qty) DESC) AS rnk
FROM orders_flat
GROUP BY customer_name
ORDER BY rnk, customer_name;

SELECT MONTH(order_date) AS m, SUM(unit_price * qty) AS total_sales
FROM orders_flat
GROUP BY MONTH(order_date)
ORDER BY m;

