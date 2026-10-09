DROP DATABASE IF EXISTS stock_db;
CREATE DATABASE stock_db;
USE stock_db;

CREATE TABLE sectors (
    sector_id INT PRIMARY KEY,
    sector_name VARCHAR(30)
);

CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(40),
    sector_id INT,
    city VARCHAR(30),
    market_cap_cr INT
);

CREATE TABLE quarterly_results (
    result_id INT PRIMARY KEY,
    company_id INT,
    quarter VARCHAR(10),
    revenue_cr INT,
    profit_cr INT
);

INSERT INTO sectors VALUES
(1, 'Paints'),
(2, 'IT'),
(3, 'Banking'),
(4, 'FMCG'),
(5, 'Auto'),
(6, 'Pharma');

INSERT INTO companies VALUES
(1,  'Asian Paints',    1,    'Mumbai',    230000),
(2,  'Berger Paints',   1,    'Kolkata',   55000),
(3,  'Infosys',         2,    'Bengaluru', 405000),
(4,  'TCS',             2,    'Mumbai',    1100000),
(5,  'HDFC Bank',       3,    'Mumbai',    1300000),
(6,  'ICICI Bank',      3,    'Mumbai',    950000),
(7,  'HUL',             4,    'Mumbai',    550000),
(8,  'Nestle India',    4,    'Gurugram',  220000),
(9,  'Maruti Suzuki',   5,    'New Delhi', 450000),
(10, 'Titan',           NULL, 'Bengaluru', 310000),
(11, 'Kansai Nerolac',  1,    'Mumbai',    28000);

INSERT INTO quarterly_results VALUES
(1,  1, 'Q1 FY26', 8800,  1100),
(2,  1, 'Q2 FY26', 8700,  1000),
(3,  2, 'Q1 FY26', 2900,  320),
(4,  2, 'Q2 FY26', 2800,  290),
(5,  3, 'Q1 FY26', 40000, 7000),
(6,  3, 'Q2 FY26', 41000, 7200),
(7,  4, 'Q1 FY26', 63000, 12000),
(8,  4, 'Q2 FY26', 64000, 12500),
(9,  5, 'Q1 FY26', 85000, 17000),
(10, 5, 'Q2 FY26', 88000, 17500),
(11, 6, 'Q1 FY26', 52000, 11000),
(12, 6, 'Q2 FY26', 54000, 11500),
(13, 7, 'Q1 FY26', 15000, 2500),
(14, 7, 'Q2 FY26', 15200, 2450),
(15, 8, 'Q1 FY26', 5000,  900),
(16, 8, 'Q2 FY26', 5200,  950),
(17, 9, 'Q1 FY26', 38000, 3700),
(18, 9, 'Q2 FY26', 36000, 3300);


select c.company_name, s.sector_name
from companies c 
INNER JOIN SECTORS s
ON c.sector_id = s.sector_id
where sector_name = 'IT';

select c.company_name, s.sector_name, c.market_cap_cr
from companies c
INNER JOIN SECTORS s
on c.sector_id = s.sector_id 
order by c.market_cap_cr desc;

select c.company_name, s.sector_name, c.market_cap_cr
from companies c
INNER JOIN SECTORS s
on c.sector_id = s.sector_id 
order by c.market_cap_cr desc
limit 3;

select c.company_name, q.quarter, q.revenue_cr
from companies c
INNER JOIN quarterly_results q
ON c.company_id = q.company_id
where revenue_cr > 50000
order by revenue_cr desc ;

select c.company_name, q.profit_cr
from companies c 
INNER JOIN quarterly_results q
ON c.company_id = q.company_id
where q.quarter = 'Q2 FY26'
ORDER BY profit_cr desc
limit 5;

select c.company_name, q.quarter
from companies c
LEFT JOIN quarterly_results q 
ON c.company_id = q.company_id 
where q.result_id IS NULL;

SELECT s.sector_name 
from sectors s
Left join companies c
ON s.sector_id = c.sector_id
where c.company_id IS NULL ;

select c.company_name, s.sector_name, q.quarter, q.profit_cr
from companies c
INNER JOIN sectors s
ON c.sector_id = s.sector_id
INNER JOIN quarterly_results q
on  c.company_id = q.company_id 
where profit_cr > 1000
order by profit_cr desc ;

select c.company_name, s.sector_name
from companies c
LEFT JOIN sectors s 
ON c.sector_id = s.sector_id
UNION ALL 
select c.company_name, s.sector_name
from companies c
RIGHT JOIN sectors s 
ON c.sector_id = s.sector_id;

select c.company_name, c.market_cap_cr 
from companies c
LEFT JOIN quarterly_results q
on c.company_id = q.company_id 
And quarter =' Q1 FY26'
WHERE c.market_cap_cr  >= 1000000
ORDER BY c.market_cap_cr DESC ;



select * from companies;
select * from quarterly_results;
select * from sectors;

