
CREATE DATABASE bank_db;
USE bank_db;

CREATE TABLE branches (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(30),
  city VARCHAR(30)
);

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(30),
  branch_id INT
);

CREATE TABLE accounts (
  account_id INT PRIMARY KEY,
  customer_id INT,
  account_type VARCHAR(20),
  balance INT
);

CREATE TABLE loans (
  loan_id INT PRIMARY KEY,
  customer_id INT,
  loan_type VARCHAR(20),
  loan_amount INT
);

INSERT INTO branches VALUES
(1, 'Meerut Main', 'Meerut'),
(2, 'Delhi Central', 'Delhi'),
(3, 'Noida Sector 18', 'Noida'),
(4, 'Jaipur Road', 'Jaipur');

INSERT INTO customers VALUES
(1, 'Rohit', 1),
(2, 'Sunita', 1),
(3, 'Vikram', 2),
(4, 'Anita', 2),
(5, 'Manish', 3),
(6, 'Pooja', 3),
(7, 'Tarun', 2);

INSERT INTO accounts VALUES
(101, 1, 'Savings', 85000),
(102, 1, 'Current', 240000),
(103, 2, 'Savings', 15000),
(104, 3, 'Savings', 52000),
(105, 4, 'Current', 410000),
(106, 4, 'Savings', 8000),
(107, 5, 'Savings', 31000),
(108, 6, 'Savings', 120000),
(109, 6, 'Current', 5000);

INSERT INTO loans VALUES
(1, 1, 'Home', 500000),
(2, 3, 'Car', 200000),
(3, 4, 'Home', 1500000),
(4, 6, 'Personal', 80000),
(5, 4, 'Personal', 120000);

select * from accounts;
select * from branches;
select * from customers;
select * from loans;

select c.customer_name, a.account_type, a.balance,
case
when a.balance  = 100000 then 'High' 
WHEN a.balance = 20000 then 'medium'
ELSE 'LOW' 
END as balance_level
from customers c
INNER JOIN accounts a
on c.customer_id = a.customer_id;

select c.customer_id, c.customer_name, a.account_type,
CASE
  WHEN a.account_type IS NOT NULL THEN 'Has account'
  ELSE 'No Account'
  END AS account_status
from customers c
LEFT JOIN accounts a
on c.customer_id = a.customer_id;

select b.branch_id, b.branch_name, count(c.customer_name) as customer_count,
case
when count(c.customer_name) =0 then 'empty'
ELSE 'Active'
END as branch_status
from branches b
LEFT JOIN customers c
ON b.branch_id = c.branch_id
GROUP BY b.branch_id, b.branch_name ;

select c.customer_id , c.customer_name,  sum(l.loan_amount) as total_loan_amount, 
CASE
     when sum(l.loan_amount) = 0  THEN 'No Loan'
     WHEN sum(l.loan_amount) >= 100000 THEN 'High Risk'
      ELSE 'Normal'
      END AS loan_level
from loans l 
RIGHT JOIN customers c
on l.customer_id = c.customer_id
GROUP BY c.customer_id , c.customer_name;

select b.branch_id, b.branch_name ,
CASE 
    WHEN SUM(a.balance) IS NULL THEN 0
    ELSE SUM(a.balance)
    END AS total_balance 
from branches b
LEFT JOIN customers c
on b.branch_id = c.branch_id 
LEFT JOIN accounts a
on c.customer_id = a.customer_id
GROUP BY b.branch_id, b.branch_name ;

select * from accounts;
select * from branches;
select * from customers;
select * from loans;