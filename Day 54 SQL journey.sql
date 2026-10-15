DROP DATABASE IF EXISTS trade_db;
CREATE DATABASE trade_db;
USE trade_db;

CREATE TABLE brokers (
    broker_id INT PRIMARY KEY,
    broker_name VARCHAR(30),
    region VARCHAR(20)
);

CREATE TABLE clients (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(30),
    city VARCHAR(30),
    broker_id INT
);

CREATE TABLE stocks (
    stock_id INT PRIMARY KEY,
    stock_name VARCHAR(30),
    sector VARCHAR(20)
);

CREATE TABLE trades (
    trade_id INT PRIMARY KEY,
    client_id INT,
    stock_id INT,
    quantity INT,
    price INT
);

INSERT INTO brokers VALUES
(1, 'Alpha Broking',     'North'),
(2, 'Bharat Securities', 'West'),
(3, 'Capital Edge',      'South'),
(4, 'Delta Trade',       'East');

INSERT INTO clients VALUES
(1, 'Rahul',  'Meerut',  1),
(2, 'Priya',  'Delhi',   1),
(3, 'Amit',   'Mumbai',  2),
(4, 'Neha',   'Pune',    2),
(5, 'Karan',  'Noida',   1),
(6, 'Simran', 'Delhi',   NULL),
(7, 'Vikas',  'Chennai', 3),
(8, 'Anjali', 'Mumbai',  2);

INSERT INTO stocks VALUES
(1, 'TCS',          'IT'),
(2, 'Infosys',      'IT'),
(3, 'HDFC Bank',    'Banking'),
(4, 'ICICI Bank',   'Banking'),
(5, 'Reliance',     'Energy'),
(6, 'Asian Paints', 'Paints'),
(7, 'Tata Motors',  'Auto');

INSERT INTO trades VALUES
(1,  1,  1,  10, 3900),
(2,  1,  3,  20, 1650),
(3,  2,  1,  5,  3950),
(4,  2,  5,  15, 2900),
(5,  3,  2,  30, 1500),
(6,  3,  3,  10, 1700),
(7,  3,  6,  8,  2900),
(8,  4,  4,  25, 1100),
(9,  5,  5,  12, 2850),
(10, 5,  1,  6,  3920),
(11, 8,  2,  20, 1520),
(12, 1,  5,  4,  2880),
(13, 99, 2,  10, 1510),
(14, 4,  88, 7,  500);

select t.trade_id, c.client_name, t.quantity
from trades t 
INNER JOIN clients c 
ON t.client_id = c.client_id 
order by trade_id ;

select t.trade_id, s.stock_name, t.price
from trades t 
INNER JOIN stocks s 
on t.stock_id = s.stock_id
order by trade_id ;

select c.client_name, t.trade_id 
from clients c
LEFT JOIN trades t 
ON c.client_id = t.client_id ;

select c.client_name
from clients c
LEFT JOIN trades t 
ON c.client_id = t.client_id 
where trade_id IS NULL;


select s.stock_name, t.trade_id 
from stocks s 
left join trades t 
ON s.stock_id = t.stock_id 
GROUP BY s.stock_name, t.trade_id  ;

select s.stock_name
from stocks s 
LEFT JOIN trades t
ON s.stock_id = t.stock_id 
Where trade_id IS NULL ; 

select c.client_id, c.client_name, b.broker_name
from brokers b
LEFT JOIN clients c 
on c.broker_id = b.broker_id;

select c.client_name, s.stock_name
from clients c
INNER  JOIN trades t 
ON  c.client_id = t.client_id 
LEFT JOIN stocks s
ON t.stock_id = s.stock_id
GROUP BY c.client_name, s.stock_name
order by client_name,
          stock_name ;

SELECT c.client_name, b.broker_name, s.stock_name, t.quantity
FROM clients c
INNER JOIN trades t
 ON c.client_id = t.client_id
INNER JOIN brokers b
 ON c.broker_id = b.broker_id
INNER JOIN stocks s 
ON t.stock_id = s.stock_id
ORDER BY c.client_name, s.stock_name;


select * from brokers;
select * from clients;
select * from stocks;
select * from trades;
