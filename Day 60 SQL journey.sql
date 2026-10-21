DROP DATABASE IF EXISTS research_db;
CREATE DATABASE research_db;
USE research_db;

CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(30),
    sector VARCHAR(20),
    market_cap_cr INT
);

CREATE TABLE results (
    result_id INT PRIMARY KEY,
    company_id INT,
    fiscal_year INT,
    revenue_cr INT,
    profit_cr INT
);

CREATE TABLE ratings (
    rating_id INT PRIMARY KEY,
    company_id INT,
    analyst_name VARCHAR(30),
    rating VARCHAR(10),
    target_price INT
);

INSERT INTO companies VALUES
(1,  'Asian Paints',  'Paints',  270000),
(2,  'Berger Paints', 'Paints',  60000),
(3,  'TCS',           'IT',      1400000),
(4,  'Infosys',       'IT',      650000),
(5,  'HDFC Bank',     'Banking', 1200000),
(6,  'ICICI Bank',    'Banking', 800000),
(7,  'Maruti Suzuki', 'Auto',    400000),
(8,  'ITC',           'FMCG',    550000),
(9,  'Sun Pharma',    'Pharma',  420000),
(10, 'Tata Motors',   'Auto',    330000);

INSERT INTO results VALUES
(1,  1, 2024, 35000,  5500),
(2,  1, 2025, 34000,  5200),
(3,  2, 2024, 11000,  1300),
(4,  2, 2025, 11800,  1350),
(5,  3, 2024, 240000, 46000),
(6,  3, 2025, 256000, 49000),
(7,  4, 2024, 153000, 26000),
(8,  4, 2025, 163000, 27000),
(9,  5, 2024, 180000, 60000),
(10, 5, 2025, 205000, 66000),
(11, 6, 2024, 150000, 40000),
(12, 6, 2025, 170000, 47000),
(13, 7, 2025, 140000, 14000);

INSERT INTO ratings VALUES
(1,  1, 'Meera Shah', 'Buy',  3200),
(2,  1, 'Rohan Iyer', 'Hold', 2900),
(3,  3, 'Meera Shah', 'Buy',  4400),
(4,  3, 'Kabir Nair', 'Hold', 4100),
(5,  4, 'Tara Das',   'Buy',  1900),
(6,  5, 'Rohan Iyer', 'Buy',  2000),
(7,  5, 'Kabir Nair', 'Hold', 1850),
(8,  6, 'Sana Roy',   'Buy',  1400),
(9,  2, 'Meera Shah', 'Sell', 480),
(10, 7, 'Yash Rao',   'Sell', 11000),
(11, 8, 'Tara Das',   'Hold', 520),
(12, 2, 'Sana Roy',   'Hold', 520);

select * from companies;
select * from ratings ;
select * from results;

select company_name, market_cap_cr 
from companies 
where market_cap_cr  > (select avg(market_cap_cr) from companies)
order by market_cap_cr desc ;

select company_id, r.fiscal_year, r.revenue_cr
from results r
where revenue_cr = (select MAX(revenue_cr) from results);

select r.analyst_name, r.target_price, r.rating
from ratings r 
where r.target_price > (select avg(target_price) from ratings)
order by target_price desc;

select c.company_name
from companies c
WHERE company_id IN (select company_id from ratings 
where rating = 'BUY')
ORDER BY company_name;

select c.company_name
from companies c
where company_id NOT IN (select company_id from ratings 
where rating = 'sell')
order by company_name;

select company_name, market_cap_cr
from companies 
where market_cap_cr < (select avg(market_cap_cr) from companies) ;

select c.company_name	
from companies c
where company_id IN (SELECT company_id from results r
where profit_cr > 40000)
order by company_name ; 

select company_name
from companies 
where company_id NOT IN  (select company_id from results )
order by company_name ;




select * from companies;
select * from ratings ;
select * from results;
