CREATE DATABASE analyst_test_db;
USE analyst_test_db;

CREATE TABLE clients (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(30),
  city VARCHAR(20),
  segment VARCHAR(20)
);
CREATE TABLE accounts (
  account_id INT PRIMARY KEY,
  client_id INT,
  account_type VARCHAR(20),
  balance INT
);
CREATE TABLE transactions (
  txn_id INT PRIMARY KEY,
  account_id INT,
  txn_type VARCHAR(20),
  amount INT
);
CREATE TABLE branches (
  branch_id INT PRIMARY KEY,
  city VARCHAR(20),
  manager VARCHAR(30)
);

INSERT INTO clients VALUES
(1,'Aarav Mehta','Meerut','Retail'),
(2,'Diya Sharma','Delhi','Retail'),
(3,'Kabir Singh','Mumbai','Corporate'),
(4,'Neha Verma','Meerut','Retail'),
(5,'Rohan Gupta','Pune','Corporate'),
(6,'Isha Kapoor','Delhi','Corporate'),
(7,'Arjun Rao','Chennai','Retail'),
(8,'Meera Iyer','Bengaluru','Corporate'),
(9,'Sahil Khan','Kanpur','Retail'),
(10,'Tanya Jain',NULL,'Retail');

INSERT INTO accounts VALUES
(101,1,'Savings',45000),
(102,1,'Loan',200000),
(103,2,'Savings',82000),
(104,3,'Current',350000),
(105,3,'Loan',900000),
(106,4,'Savings',15000),
(107,5,'Current',520000),
(108,6,'Savings',140000),
(109,6,'Current',275000),
(110,7,'Savings',30000),
(111,8,'Current',610000),
(112,8,'Savings',95000),
(113,2,'Current',60000),
(114,5,'Loan',450000);

INSERT INTO transactions VALUES
(1,101,'Deposit',10000),
(2,101,'Withdrawal',5000),
(3,103,'Deposit',20000),
(4,104,'Deposit',150000),
(5,104,'Withdrawal',40000),
(6,106,'Deposit',3000),
(7,107,'Deposit',200000),
(8,107,'Fee',500),
(9,108,'Deposit',25000),
(10,108,'Withdrawal',10000),
(11,109,'Deposit',80000),
(12,110,'Withdrawal',2000),
(13,111,'Deposit',300000),
(14,111,'Fee',800),
(15,112,'Deposit',15000),
(16,103,'Withdrawal',7000),
(17,113,'Deposit',12000),
(18,104,'Fee',600),
(19,109,'Withdrawal',30000),
(20,101,'Deposit',8000);

INSERT INTO branches VALUES
(1,'Meerut','R. Saxena'),
(2,'Delhi','A. Malhotra'),
(3,'Mumbai','S. Desai'),
(4,'Jaipur','K. Rathore'),
(5,'Lucknow','P. Tiwari');

select * from accounts;
select * from branches;
select * from clients;
select * from transactions;

select client_name, city
from clients
where city IN ('Meerut','Delhi')
order by client_name  ;

select a.account_id, a.balance 
from accounts a
where account_type = 'Savings'
order by  a.balance  desc
limit 3;

select count(account_id)as total_counts,
       sum(balance)as total_balance,
       avg(balance) as avg_balance
from accounts
where account_type = 'current';

select a.account_type, 
        count(a.account_type)as account_type,
	    sum(balance)as total_balance
from accounts a 
group by  a.account_type
 order by sum(balance) DESC;
 
 select a.client_id,
sum(a.balance)as total_balance
from accounts a 
group by a.client_id
having sum(a.balance) > 500000
order by sum(a.balance) desc ;

select 
 CASE 
    WHEN balance >= 300000 Then 'High' 
	WHEN balance = 1000000 then 'medium '
	ELSE 'Low'
    END AS balance_level,
    count(*) as account_count
    from accounts a
GROUP BY balance_level
ORDER BY account_count DESC;

select client_name
from clients 
where city IS NULL;

SELECT c.client_name, a.account_type, a.balance 
from clients c
INNER JOIN accounts a 
ON c.client_id = a.client_id 
where a.account_type = 'Loan'
order by  a.balance  desc ;

select c.client_name, t.txn_type, t.amount
from accounts a 
INNER JOIN clients c
ON c.client_id = a.client_id 
INNER JOIN transactions t 
ON a.account_id = t.account_id
where t.txn_type = 'Withdrawal' AND t.amount > 5000
order by t.amount desc ;

SELECT c.client_name
from clients c 
where client_id NOT IN (select client_id from accounts 
 where client_id is  NOT NULL)
 ORDER BY client_name;

select c.client_name,
       sum(t.amount)as total_deposit_amount
 from accounts a 
INNER JOIN clients c
ON c.client_id = a.client_id 
INNER JOIN transactions t 
ON a.account_id = t.account_id
WHERE t.txn_type = 'Deposit'
GROUP BY c.client_name
order by  total_deposit_amount desc  ;

select a.account_id , a.account_type, a.balance 
from accounts a 
where a.balance > (select avg(balance) from accounts )
order by  a.balance  desc;

SELECT DISTINCT c.client_name
FROM transactions t
INNER JOIN accounts a
 ON t.account_id = a.account_id
INNER JOIN clients c
 ON a.client_id = c.client_id
WHERE t.txn_type = 'Fee'
ORDER BY c.client_name;

SELECT a.account_id , a.account_type 
from accounts a
where account_id  NOT IN (SELECT account_id from transactions 
    where account_id is NOT NULL)
    ORDER BY account_id;
    
SELECT city FROM clients 
WHERE city IS NOT NULL
UNION
SELECT city FROM branches
ORDER BY city;


SELECT city FROM clients 
WHERE city IS NOT NULL
UNION ALL
SELECT city FROM branches
ORDER BY city;




select * from accounts;
select * from branches;
select * from clients;
select * from transactions;

