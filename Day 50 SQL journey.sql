DROP DATABASE IF EXISTS portfolio_db;
CREATE DATABASE portfolio_db;
USE portfolio_db;

CREATE TABLE investors (
    investor_id INT PRIMARY KEY,
    investor_name VARCHAR(30),
    city VARCHAR(30)
);

CREATE TABLE stocks (
    stock_id INT PRIMARY KEY,
    stock_name VARCHAR(40),
    sector VARCHAR(30)
);

CREATE TABLE trades (
    trade_id INT PRIMARY KEY,
    investor_id INT,
    stock_id INT,
    trade_type VARCHAR(4),
    quantity INT,
    price INT,
    trade_date DATE
);

INSERT INTO investors VALUES
(1, 'Aarav', 'Meerut'),
(2, 'Diya',  'Delhi'),
(3, 'Kabir', 'Mumbai'),
(4, 'Isha',  'Meerut'),
(5, 'Rohan', 'Delhi'),
(6, 'Mira',  'Mumbai'),
(7, 'Neel',  'Noida');

INSERT INTO stocks VALUES
(1, 'Asian Paints', 'Paints'),
(2, 'Berger Paints','Paints'),
(3, 'Infosys',      'IT'),
(4, 'TCS',          'IT'),
(5, 'HDFC Bank',    'Banking'),
(6, 'ICICI Bank',   'Banking'),
(7, 'HUL',          'FMCG'),
(8, 'Maruti',       'Auto'),
(9, 'Titan',        'Consumer');

INSERT INTO trades VALUES
(1,  1,    1, 'BUY',  10,  2800,  '2026-08-03'),
(2,  1,    3, 'BUY',  20,  1500,  '2026-08-05'),
(3,  1,    1, 'SELL', 5,   2900,  '2026-08-20'),
(4,  2,    5, 'BUY',  50,  1600,  '2026-08-04'),
(5,  2,    6, 'BUY',  40,  1100,  '2026-08-10'),
(6,  2,    5, 'SELL', 20,  1700,  '2026-09-02'),
(7,  3,    4, 'BUY',  15,  3500,  '2026-08-06'),
(8,  3,    3, 'BUY',  30,  1450,  '2026-08-12'),
(9,  3,    4, 'SELL', 5,   3600,  '2026-09-05'),
(10, 4,    7, 'BUY',  25,  2400,  '2026-08-08'),
(11, 4,    2, 'BUY',  60,  450,   '2026-08-15'),
(12, 5,    8, 'BUY',  4,   11000, '2026-08-09'),
(13, 5,    1, 'BUY',  8,   2750,  '2026-08-18'),
(14, 5,    8, 'SELL', 4,   11500, '2026-09-10'),
(15, NULL, 5, 'BUY',  100, 1650,  '2026-08-11'),
(16, NULL, 4, 'SELL', 10,  3550,  '2026-09-08'),
(17, 4,    5, 'BUY',  30,  1620,  '2026-09-12'),
(18, 1,    7, 'BUY',  12,  2450,  '2026-09-15');


select * from investors;
select * from stocks;
select * from trades;

select t.trade_type, i.investor_name, s.stock_name, sum(t.quantity * t.price)AS trade_value
from trades t 
INNER JOIN  investors i 
ON t.investor_id = i.investor_id 
INNER JOIN stocks s 
ON t.stock_id = s.stock_id
where trade_type = 'BUY'
GROUP BY  t.trade_type, i.investor_name, s.stock_name
order by trade_value desc  
LIMIT 3;

SELECT s.sector, sum(t.quantity * t.price)AS total_traded, count(t.trade_id)as trade_count
from stocks s 
LEFT JOIN trades t 
ON s.stock_id = t.stock_id
GROUP BY s.sector
HAVING  total_traded > 150000
order by total_traded desc ;

select i.investor_name, 
sum(CASE WHEN t.trade_type = 'BUY' THEN t.quantity * t.price ELSE 0  END)as total_bought,
sum(CASE WHEN t.trade_type = 'SELL' THEN t.quantity * t.price ELSE 0  END)as total_sold
FROM investors i 
Left join trades t 
ON i.investor_id = t.investor_id 
GROUP BY i.investor_name
order by total_bought desc,
          i.investor_name asc;
          
