CREATE DATABASE IF NOT EXISTS keys_practice_db;
USE keys_practice_db;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(30),
  city VARCHAR(20)
);

CREATE TABLE accounts (
  account_id INT PRIMARY KEY,
  customer_id INT,
  balance INT,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE cards (
  card_id INT PRIMARY KEY,
  customer_id INT,
  card_type VARCHAR(10),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT
);

INSERT INTO customers VALUES (1,'Rahul','Meerut'),(2,'Sana','Delhi'),(3,'Vivek','Noida');
INSERT INTO accounts VALUES (101,1,50000),(102,1,20000),(103,2,75000),(104,3,10000);
INSERT INTO cards VALUES (501,1,'Debit'),(502,2,'Credit');

INSERT INTO customers VALUES 
(1, "Duplicte", "Agra");


INSERT INTO accounts VALUES (105,99,5000);

DELETE FROM customers WHERE customer_id = 1;

DELETE FROM cards WHERE customer_id = 1;
DELETE FROM customers WHERE customer_id = 1;

SELECT * FROM accounts;      

CREATE INDEX idx_accounts_customer ON accounts(customer_id);
SHOW INDEX FROM accounts;
EXPLAIN SELECT * FROM accounts WHERE customer_id = 2;

