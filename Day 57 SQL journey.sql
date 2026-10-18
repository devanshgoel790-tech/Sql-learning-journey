DROP DATABASE IF EXISTS fund_db;
CREATE DATABASE fund_db;
USE fund_db;

CREATE TABLE funds (
    fund_id INT PRIMARY KEY,
    fund_name VARCHAR(30),
    category VARCHAR(20),
    nav DECIMAL(6,2),
    aum_cr INT
);

CREATE TABLE investments (
    investment_id INT PRIMARY KEY,
    investor_name VARCHAR(30),
    fund_id INT,
    amount INT
);

INSERT INTO funds VALUES
(1, 'Bluechip Equity',    'Equity', 85.50,  1200),
(2, 'Midcap Growth',      'Equity', 120.00, 800),
(3, 'Small Cap Star',     'Equity', 60.25,  450),
(4, 'Govt Bond Fund',     'Debt',   32.40,  1500),
(5, 'Liquid Fund',        'Debt',   25.10,  2000),
(6, 'Gold Saver',         'Gold',   18.75,  300),
(7, 'Balanced Advantage', 'Hybrid', 55.00,  950),
(8, 'Tax Saver ELSS',     'Equity', 42.80,  700);

INSERT INTO investments VALUES
(1,  'Aarav', 1, 50000),
(2,  'Aarav', 4, 30000),
(3,  'Diya',  2, 80000),
(4,  'Diya',  1, 40000),
(5,  'Kabir', 5, 100000),
(6,  'Meera', 1, 25000),
(7,  'Rohan', 7, 60000),
(8,  'Sana',  4, 20000),
(9,  'Tara',  2, 15000),
(10, 'Yash',  8, 35000),
(11, 'Isha',  5, 45000),
(12, 'Hina',  1, 10000);

select * from funds ; 
select * from investments;

select avg(f.nav) from funds f;

select f.fund_name, f.nav
from funds f
where f.nav > '54.975000';

select f.fund_name, f.nav
from funds f
where f.nav > (select avg(f.nav) from funds f)
order by f.nav desc;

select MAX(f.aum_cr) from funds f ;

select f.fund_name, f.aum_cr
from funds f
where f.aum_cr = 2000;

select f.fund_name, f.aum_cr
from funds f
where f.aum_cr = (select MAX(f.aum_cr) from funds ) 
ORDER BY f.aum_cr DESC;

SELECT i.investor_name, i.amount 
from investments i 
where amount > (select avg(i.amount) from investments i)
order by i.amount desc ;

select f.fund_name
from funds f
where f.fund_id in (select fund_id from investments) 
order by fund_name;

select f.fund_name 
from funds f 
where fund_id NOT IN (select fund_id from investments) ;

select * from funds ; 
select * from investments;