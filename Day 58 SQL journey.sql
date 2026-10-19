DROP DATABASE IF EXISTS portfolio_db;
CREATE DATABASE portfolio_db;
USE portfolio_db;

CREATE TABLE stocks (
    stock_id INT PRIMARY KEY,
    company VARCHAR(30),
    sector VARCHAR(20),
    price INT
);

CREATE TABLE holdings (
    holding_id INT PRIMARY KEY,
    investor_name VARCHAR(30),
    stock_id INT,
    quantity INT
);

INSERT INTO stocks VALUES
(1, 'TCS',            'IT',      3900),
(2, 'Infosys',        'IT',      1500),
(3, 'HDFC Bank',      'Banking', 1650),
(4, 'ICICI Bank',     'Banking', 1100),
(5, 'Maruti Suzuki',  'Auto',    12500),
(6, 'ITC',            'FMCG',    450),
(7, 'Sun Pharma',     'Pharma',  1600),
(8, 'Tata Motors',    'Auto',    950);

INSERT INTO holdings VALUES
(1,  'Aarav', 1, 50),
(2,  'Aarav', 6, 300),
(3,  'Diya',  3, 120),
(4,  'Diya',  2, 80),
(5,  'Kabir', 6, 500),
(6,  'Meera', 4, 200),
(7,  'Rohan', 1, 20),
(8,  'Sana',  5, 10),
(9,  'Tara',  3, 150),
(10, 'Yash',  2, 60),
(11, 'Isha',  6, 100),
(12, 'Hina',  4, 90);

select avg(s.price) from stocks s ;

select s.company, s.price
from stocks s
where s.price < '2956.2500'  ;

select s.company, s.price
from stocks s
where s.price < (select avg(s.price) from stocks s);

select s.company, s.price
from stocks s 
where s.price = (select max(s.price) from stocks s);

select h.investor_name, h.quantity
from holdings h 
where h.quantity > (select avg(h.quantity) from holdings h );

SELECT company
FROM stocks
WHERE stock_id IN (SELECT stock_id FROM holdings WHERE quantity > 100)
ORDER BY company ;

SELECT company
FROM stocks
WHERE stock_id NOT IN (SELECT stock_id FROM holdings)
ORDER BY company;

select company 
from stocks 
where stock_id in (select stock_id from holdings where investor_name = 'Aarav') ;

select company
from stocks 
where stock_id NOT IN (SELECT stock_id from holdings where investor_name = 'Diya')
order by company;

select * from holdings;
select * from stocks


