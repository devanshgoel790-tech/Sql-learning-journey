CREATE DATABASE IF NOT EXISTS credit_card_db;
USE credit_card_db;

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS cards;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name        VARCHAR(30),
  city        VARCHAR(20),
  segment     VARCHAR(15)
);

CREATE TABLE cards (
  card_id      INT PRIMARY KEY,
  customer_id  INT,
  card_type    VARCHAR(15),
  credit_limit INT
);

CREATE TABLE transactions (
  txn_id            INT PRIMARY KEY,
  card_id           INT,
  txn_date          DATE,
  merchant_category VARCHAR(20),
  amount            INT,
  status            VARCHAR(15)
);

INSERT INTO customers VALUES
(1,  'Ananya Sharma', 'Delhi',     'Premium'),
(2,  'Rohan Verma',   'Mumbai',    'Regular'),
(3,  'Sneha Iyer',    'Chennai',   'Premium'),
(4,  'Karan Malhotra','Delhi',     'Regular'),
(5,  'Pooja Reddy',   'Hyderabad', 'Premium'),
(6,  'Vikram Joshi',  'Mumbai',    'Regular'),
(7,  'Meera Nair',    'Chennai',   'Regular'),
(8,  'Aditya Singh',  'Delhi',     'Premium'),
(9,  'Neha Gupta',    'Hyderabad', 'Regular'),
(10, 'Sameer Khan',   'Mumbai',    'Premium');

INSERT INTO cards VALUES
(1,  1, 'Platinum', 300000),
(2,  1, 'Classic',  100000),
(3,  2, 'Classic',   80000),
(4,  3, 'Platinum', 250000),
(5,  4, 'Gold',     150000),
(6,  5, 'Gold',     200000),
(7,  6, 'Classic',   90000),
(8,  7, 'Gold',     120000),
(9,  8, 'Platinum', 400000),
(10, 8, 'Gold',     150000),
(11, 5, 'Classic',   60000),
(12, 2, 'Gold',     130000);

INSERT INTO transactions VALUES
(1,  1, '2026-08-05', 'Groceries',   4200,  'Success'),
(2,  1, '2026-08-19', 'Travel',      38500, 'Success'),
(3,  1, '2026-09-02', 'Dining',      2650,  'Success'),
(4,  2, '2026-08-11', 'Shopping',    7800,  'Success'),
(5,  2, '2026-09-14', 'Electronics', 24500, 'Failed'),
(6,  3, '2026-08-23', 'Fuel',        3100,  'Success'),
(7,  3, '2026-09-08', 'Groceries',   5400,  'Success'),
(8,  3, '2026-10-01', 'Dining',      1900,  'Refunded'),
(9,  4, '2026-08-30', 'Travel',      52000, 'Success'),
(10, 4, '2026-09-17', 'Electronics', 64000, 'Success'),
(11, 4, '2026-10-09', NULL,          8900,  'Success'),
(12, 5, '2026-09-05', 'Fuel',        2800,  'Success'),
(13, 5, '2026-09-26', 'Groceries',   6100,  'Success'),
(14, 6, '2026-08-14', 'Shopping',    11200, 'Success'),
(15, 6, '2026-09-20', 'Dining',      3300,  'Failed'),
(16, 6, '2026-10-12', 'Travel',      27400, 'Success'),
(17, 7, '2026-09-11', 'Groceries',   4800,  'Success'),
(18, 7, '2026-10-03', NULL,          15600, 'Success'),
(19, 8, '2026-08-27', 'Electronics', 41000, 'Success'),
(20, 8, '2026-09-29', 'Shopping',    9200,  'Success'),
(21, 9, '2026-08-08', 'Travel',      86000, 'Success'),
(22, 9, '2026-09-13', 'Dining',      5200,  'Success'),
(23, 9, '2026-10-06', 'Electronics', 72500, 'Refunded'),
(24, 9, '2026-10-21', 'Fuel',        3600,  'Success'),
(25, 11,'2026-09-18', 'Groceries',   2200,  'Success'),
(26, 11,'2026-10-15', 'Shopping',    6700,  'Success'),
(27, 12,'2026-09-09', 'Dining',      4100,  'Success'),
(28, 12,'2026-10-18', NULL,          12300, 'Failed'),
(29, 1, '2026-10-22', 'Groceries',   3900,  'Success'),
(30, 4, '2026-10-26', 'Fuel',        3400,  'Success');

SELECT * FROM cards;
SELECT * FROM customers;
SELECT * FROM transactions;

SELECT c.name,
         c.segment
FROM customers c
where city = "Delhi"
ORDER BY name ASC;

SELECT txn_id, 
       txn_date,
       amount
FROM transactions t
WHERE txn_date BETWEEN  "2026-01-01" AND "2026-9-30"
ORDER BY txn_date ASC;

select txn_id ,
       card_id,
       amount
FROM transactions 
where merchant_category IS NULL ;

SELECT merchant_category,
       SUM(amount)as total_amount
FROM transactions 
where status = "Success"and merchant_category IS NOT  NULL
GROUP BY merchant_category
ORDER BY total_amount DESC ;

SELECT card_id, card_type 
FROM cards 
WHERE card_id NOT IN (SELECT DISTINCT card_id FROM transactions);

SELECT c.card_type,
       SUM(CASE WHEN t.status = 'Success' THEN 1 ELSE 0 END) AS success_count,
       SUM(CASE WHEN t.status = 'Failed' THEN 1 ELSE 0 END) AS failed_count,
       SUM(CASE WHEN t.status = 'Refunded' THEN 1 ELSE 0 END) AS refunded_count
FROM cards c
RIGHT JOIN transactions t ON c.card_id = t.card_id
GROUP BY c.card_type;

 SELECT c.name,
        COUNT(t.txn_id) as total_transactions
FROM customers c
INNER JOIN cards ca
ON c.customer_id = ca.customer_id 
INNER JOIN transactions t
ON ca.card_id = t.card_id
GROUP BY c.name
HAVING   COUNT(t.txn_id) >= 4 
ORDER BY  COUNT(t.txn_id) DESC, c.name ASC;

SELECT txn_id ,
       amount
FROM transactions 
 WHERE status = "Success"
 AND amount > (select AVG(amount) FROM transactions
 WHERE status = "Success")
 ORDER BY amount DESC;
 
 SELECT cu.city, ROUND(AVG(t.amount), 2) AS avg_amount
FROM customers cu
JOIN cards c ON cu.customer_id = c.customer_id
JOIN transactions t ON c.card_id = t.card_id
WHERE t.status = 'Success'
GROUP BY cu.city
ORDER BY avg_amount DESC;
 
 SELECT card_id, txn_date, amount,
       SUM(amount) OVER(PARTITION BY card_id ORDER BY txn_date) AS running_total
FROM transactions
WHERE card_id IN (1, 4) AND status = 'Success'
ORDER BY card_id, txn_date;


 
SELECT * FROM cards;
SELECT * FROM customers;
SELECT * FROM transactions;


