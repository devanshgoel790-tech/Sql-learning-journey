CREATE DATABASE IF NOT EXISTS bank_db;
USE bank_db;

DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name        VARCHAR(30),
  city        VARCHAR(20)
);

CREATE TABLE accounts (
  account_id   INT PRIMARY KEY,
  customer_id  INT,
  account_type VARCHAR(15),
  balance_text VARCHAR(15),
  status       VARCHAR(10)
);

CREATE TABLE loans (
  loan_id          INT PRIMARY KEY,
  customer_id      INT,
  loan_amount_text VARCHAR(15),
  loan_type        VARCHAR(15),
  status           VARCHAR(10)
);

INSERT INTO customers VALUES
(1,  'Aarav Mehta',  'Delhi'),
(2,  'Riya Das',     'Mumbai'),
(3,  'Kabir Singh',  'Pune'),
(4,  'Maya Shah',    'Jaipur'),
(5,  'Noah Patel',   'Delhi'),
(6,  'Zoya Khan',    'Mumbai'),
(7,  'Isha Rao',     'Pune'),
(8,  'Arjun Nair',   'Jaipur'),
(9,  'Neha Gupta',   'Hyderabad'),
(10, 'Sameer Khan',  'Mumbai');

INSERT INTO accounts VALUES
(1,  1, 'Savings', '125000', 'Active'),
(2,  1, 'FD',      '500000', 'Active'),
(3,  2, 'Savings', '9500',   'Active'),
(4,  3, 'Current', '82000',  'Active'),
(5,  3, 'Savings', '1500',   'Closed'),
(6,  4, 'Savings', '45000',  'Active'),
(7,  5, 'Savings', '900',    'Active'),
(8,  6, 'Current', '210000', 'Active'),
(9,  6, 'FD',      '300000', 'Active'),
(10, 7, 'Savings', '12000',  'Closed'),
(11, 9, 'Savings', '76000',  'Active'),
(12, 9, 'Current', '8800',   'Active');

INSERT INTO loans VALUES
(1, 1,  '2500000', 'Home',     'Running'),
(2, 3,  '400000',  'Car',      'Running'),
(3, 6,  '150000',  'Personal', 'Closed'),
(4, 6,  '900000',  'Home',     'Running'),
(5, 9,  '200000',  'Personal', 'Running'),
(6, 10, '75000',   'Personal', 'Closed');


SELECT * FROM accounts;
SELECT * FROM customers;
SELECT * FROM loans;

SELECT account_id,
       CAST(balance_text AS SIGNED) AS balance
FROM accounts;

SELECT account_id,
       CAST(balance_text AS SIGNED) AS balance
FROM accounts
WHERE CAST(balance_text AS SIGNED) > 50000
ORDER BY account_id;


SELECT account_id,
       CAST(balance_text AS SIGNED) AS balance
FROM accounts
ORDER BY CAST(balance_text AS SIGNED) DESC;


SELECT account_type,
       SUM(CAST(balance_text AS SIGNED)) AS total_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;


SELECT c.customer_id, c.name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM accounts a
    WHERE a.customer_id = c.customer_id
)
ORDER BY c.customer_id;


SELECT c.customer_id, c.name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM accounts a
    WHERE a.customer_id = c.customer_id
)
ORDER BY c.customer_id;


SELECT c.name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM accounts a
    WHERE a.customer_id = c.customer_id
      AND a.status = 'Active'
      AND CAST(a.balance_text AS SIGNED) > 100000
)
ORDER BY c.name;

SELECT c.name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM loans l
    WHERE l.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1 FROM accounts a
    WHERE a.customer_id = c.customer_id
);

SELECT c.name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM accounts a
    WHERE a.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1 FROM loans l
    WHERE l.customer_id = c.customer_id
)
ORDER BY c.name;


SELECT c.name,
       SUM(CAST(a.balance_text AS SIGNED)) AS total_balance
FROM customers c
INNER JOIN accounts a ON c.customer_id = a.customer_id
WHERE EXISTS (
    SELECT 1
    FROM loans l
    WHERE l.customer_id = c.customer_id
      AND l.status = 'Running'
)
GROUP BY c.customer_id, c.name
ORDER BY total_balance DESC;