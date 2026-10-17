DROP DATABASE IF EXISTS insurance_db;
CREATE DATABASE insurance_db;
USE insurance_db;

CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(30),
    city VARCHAR(30)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(30),
    city VARCHAR(30),
    agent_id INT
);

CREATE TABLE policies (
    policy_id INT PRIMARY KEY,
    customer_id INT,
    policy_type VARCHAR(20),
    premium INT,
    status VARCHAR(10)
);

CREATE TABLE claims (
    claim_id INT PRIMARY KEY,
    policy_id INT,
    claim_amount INT,
    claim_status VARCHAR(10)
);

INSERT INTO agents VALUES
(1, 'Mohit',   'Delhi'),
(2, 'Pooja',   'Mumbai'),
(3, 'Sandeep', 'Meerut'),
(4, 'Rekha',   'Pune');

INSERT INTO customers VALUES
(1, 'Aditya', 'Delhi',  1),
(2, 'Bhavna', 'Mumbai', 2),
(3, 'Chirag', 'Meerut', 3),
(4, 'Divya',  'Delhi',  1),
(5, 'Esha',   'Pune',   NULL),
(6, 'Farhan', 'Mumbai', 2),
(7, 'Gaurav', 'Meerut', 3),
(8, 'Hina',   'Noida',  1);

INSERT INTO policies VALUES
(1,  1,  'Health', 12000, 'Active'),
(2,  1,  'Life',   25000, 'Active'),
(3,  2,  'Health', 15000, 'Active'),
(4,  3,  'Motor',  8000,  'Lapsed'),
(5,  3,  'Health', 11000, 'Active'),
(6,  4,  'Life',   30000, 'Active'),
(7,  4,  'Motor',  9000,  'Active'),
(8,  6,  'Health', 14000, 'Lapsed'),
(9,  7,  'Life',   28000, 'Active'),
(10, 2,  'Motor',  7500,  'Active'),
(11, 99, 'Health', 10000, 'Active');

INSERT INTO claims VALUES
(1, 1,  5000,  'Approved'),
(2, 1,  3000,  'Rejected'),
(3, 3,  12000, 'Approved'),
(4, 4,  6000,  'Rejected'),
(5, 6,  20000, 'Approved'),
(6, 9,  15000, 'Approved'),
(7, 7,  4000,  'Approved'),
(8, 50, 9000,  'Pending');

select  c.customer_name, p.policy_type, p.premium
from policies p 
INNER JOIN customers c 
ON p.customer_id = c.customer_id 
order by customer_name,
         policy_type;
         
select c.customer_name ,p.policy_type
from customers c 
LEFT JOIN policies p
ON c.customer_id = p.customer_id
order by customer_name,
         policy_type;
         
select c.customer_name, c.city 
from customers c 
LEFT JOIN policies p 
on c.customer_id = p.customer_id 
where p.policy_id IS NULL;

select p.policy_id, p.policy_type, c.customer_name
from policies p 
LEFT JOIN customers c 
ON p.customer_id = c.customer_id 
GROUP BY p.policy_id, p.policy_type
order by  p.policy_id;

SELECT p.policy_id, p.policy_type
from policies p 
LEFT JOIN claims c 
ON p.policy_id = c.policy_id 
where c.policy_id IS NULL
order by p.policy_id ;

SELECT c.customer_name, p.policy_type, cl.claim_amount 
from policies p 
INNER JOIN customers c 
ON p.customer_id = c.customer_id 
INNER JOIN claims cl 
ON p.policy_id = cl.policy_id
order by  cl.claim_amount  desc  ;

select c.customer_name, sum(p.premium)as total_premium 
from customers c
INNER JOIN policies p 
ON c.customer_id = p.customer_id 
GROUP BY  c.customer_name
order by sum(p.premium) desc;

select a.agent_id , a.agent_name, count(c.customer_id) as numbers_of_customer 
from customers c 
RIGHT JOIN  agents a 
ON c.agent_id = a.agent_id 
GROUP BY a.agent_id , a.agent_name
ORDER BY count(c.customer_id) DESC,
          a.agent_name ;
          

SELECT a.agent_name, SUM(cl.claim_amount) AS total_approved_claims
FROM agents a
INNER JOIN customers c 
ON a.agent_id = c.agent_id
INNER JOIN policies p 
ON c.customer_id = p.customer_id
INNER JOIN claims cl 
ON p.policy_id = cl.policy_id
WHERE cl.claim_status = 'Approved'
GROUP BY a.agent_name
ORDER BY total_approved_claims DESC;

SELECT c.customer_name, c.city ,sum(P.premium) as total_premium
from customers c
INNER JOIN policies p 
ON c.customer_id = p.customer_id 
group by c.customer_name, c.city 
HAVING sum(P.premium)> 30000
ORDER BY sum(P.premium) DESC 
LIMIT 2;



select * from agents ;
select * from claims;
select * from customers;
select * from policies;
