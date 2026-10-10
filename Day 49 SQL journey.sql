DROP DATABASE IF EXISTS food_db;
CREATE DATABASE food_db;
USE food_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(30),
    city VARCHAR(30)
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(40),
    cuisine VARCHAR(30)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_date DATE,
    amount INT,
    status VARCHAR(15)
);

INSERT INTO customers VALUES
(1, 'Aarav', 'Meerut'),
(2, 'Diya',  'Delhi'),
(3, 'Kabir', 'Meerut'),
(4, 'Isha',  'Noida'),
(5, 'Rohan', 'Delhi'),
(6, 'Mira',  'Meerut'),
(7, 'Neel',  'Noida');

INSERT INTO restaurants VALUES
(101, 'Spice Hub',      'North Indian'),
(102, 'Dragon Wok',     'Chinese'),
(103, 'Pizza Point',    'Italian'),
(104, 'Burger Barn',    'Fast Food'),
(105, 'Sweet Tooth',    'Dessert'),
(106, 'Tandoor Nights', 'North Indian');

INSERT INTO orders VALUES
(1,  1,    101, '2026-09-01', 450,  'Delivered'),
(2,  1,    102, '2026-09-03', 380,  'Delivered'),
(3,  2,    101, '2026-09-03', 520,  'Delivered'),
(4,  2,    103, '2026-09-05', 760,  'Cancelled'),
(5,  3,    104, '2026-09-06', 220,  'Delivered'),
(6,  3,    101, '2026-09-08', 610,  'Delivered'),
(7,  4,    103, '2026-09-09', 840,  'Delivered'),
(8,  4,    102, '2026-09-10', 300,  'Pending'),
(9,  5,    104, '2026-09-11', 180,  'Delivered'),
(10, 5,    106, '2026-09-12', 950,  'Delivered'),
(11, 1,    103, '2026-09-14', 700,  'Delivered'),
(12, 2,    102, '2026-09-15', 410,  'Delivered'),
(13, NULL, 101, '2026-09-16', 330,  'Delivered'),
(14, NULL, 104, '2026-09-17', 250,  'Cancelled'),
(15, 3,    106, '2026-09-18', 1200, 'Delivered'),
(16, 4,    101, '2026-09-20', 560,  'Delivered');



select c.customer_name, r.restaurant_name, o.amount,
CASE
 WHEN o.amount >= 700 THEN 'Big' 
 WHEN o.amount >= 400  THEN 'Medium'
 ELSE 'Small'
 END as order_size
 FROM CUSTOMERS c 
 INNER JOIN orders o 
 ON c.customer_id = o.customer_id 
 INNER JOIN restaurants r 
 ON r.restaurant_id = o.restaurant_id
 order by o.amount desc;
 
 select customer_name,
   SUM(case when o.status = 'Delivered' then o.amount ELSE 0 END) as total_spent 
   FROM customers c
   left  JOIN  orders o 
    ON c.customer_id = o.customer_id 
    group by c.customer_name
    ORDER BY  total_spent desc;
    
select r.restaurant_name,
SUM(CASE WHEN o.status = 'Delivered' then 1 else 0  end )as delivered_orders,
SUM(CASE WHEN o.status = 'cancelled' then 1 else 0 end )as cancelled_orders
FROM restaurants r 
LEFT JOIN ORDERS o 
ON r.restaurant_id = o.restaurant_id 
GROUP BY  r.restaurant_name
ORDER BY r.restaurant_name ;

select c.customer_name, count(o.order_id) as total_orders,
case when count(o.order_id) = 0 THEN 'Never Ordered'
     when count(o.order_id) <= 2 THEN 'Occasional'
     ELSE 'regular'
 END AS loyalty
 from customers c 
 LEFT JOIN orders o 
 ON c.customer_id = o.customer_id 
 group by c.customer_id , c.customer_name
 order by count(o.order_id) desc  ;
 
 select c.customer_name, c.city, sum(o.amount)as total_spent,
 CASE WHEN sum(o.amount) >= 1800 THEN 'Gold' 
	WHEN sum(o.amount) >= 1200 THEN 'Silver'
   ELSE 'Bronze'
   END AS tier
 FROM customers c
 INNER  JOIN ORDERS o
 ON c.customer_id = o.customer_id 
 WHERE o.status = 'Delivered'
 GROUP BY  c.customer_name, c.city
 order by total_spent desc
 limit 3;


SELECT c.customer_name, o.order_id, o.amount,
  CASE WHEN o.order_id IS NULL THEN 'No Orders'
       WHEN c.customer_id IS NULL THEN 'Guest Order'
       ELSE 'Regular' END AS order_type
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_name, o.order_id, o.amount,
  CASE WHEN o.order_id IS NULL THEN 'No Orders'
       WHEN c.customer_id IS NULL THEN 'Guest Order'
       ELSE 'Regular' END AS order_type
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;
 
select * from customers;
select * from orders ;
select * from restaurants;

