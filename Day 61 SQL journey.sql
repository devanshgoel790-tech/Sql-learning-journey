DROP DATABASE IF EXISTS lending_db;
CREATE DATABASE lending_db;
USE lending_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(30),
    city VARCHAR(30)
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(20),
    amount INT,
    interest_rate DECIMAL(4,1)
);

CREATE TABLE repayments (
    repayment_id INT PRIMARY KEY,
    loan_id INT,
    paid_amount INT
);

INSERT INTO customers VALUES
(1, 'Aarav', 'Meerut'),
(2, 'Diya',  'Delhi'),
(3, 'Kabir', 'Meerut'),
(4, 'Meera', 'Noida'),
(5, 'Rohan', 'Delhi'),
(6, 'Sana',  'Pune'),
(7, 'Tara',  'Mumbai'),
(8, 'Yash',  'Noida');

INSERT INTO loans VALUES
(1,  1, 'Home',      2500000, 8.5),
(2,  1, 'Car',       600000,  9.5),
(3,  2, 'Home',      4000000, 8.7),
(4,  3, 'Personal',  300000,  12.5),
(5,  4, 'Home',      3500000, 8.6),
(6,  5, 'Education', 800000,  9.0),
(7,  6, 'Personal',  200000,  13.0),
(8,  7, 'Car',       700000,  9.8),
(9,  2, 'Personal',  150000,  14.0),
(10, 4, 'Car',       500000,  9.6);

INSERT INTO repayments VALUES
(1, 1, 25000),
(2, 1, 25000),
(3, 3, 40000),
(4, 4, 10000),
(5, 5, 35000),
(6, 6, 20000),
(7, 8, 15000),
(8, 9, 5000);

select * from customers; 
select * from loans;
select * from repayments;

select loan_id, loan_type, amount 
from loans 
where amount > (select avg(amount) from loans)
order by  amount  desc;

select loan_id, interest_rate 
from loans 
where interest_rate = (select max(interest_rate) from loans );

select c.customer_name, l.loan_type
from customers c
LEFT JOIN loans l
ON c.customer_id = l.customer_id 
where l.loan_type = 'Home'
order by c.customer_name;

select loan_id, loan_type, amount 
from loans
WHERE loan_id NOT IN (SELECT loan_id  from repayments
  where loan_id is NOT NULL)
  ORDER BY loan_id ;

select c.customer_name, amount 
from customers c
INNER JOIN loans l 
ON c.customer_id = l.customer_id 
where l.amount > (select Avg(amount) from loans)
order by l.amount desc;




