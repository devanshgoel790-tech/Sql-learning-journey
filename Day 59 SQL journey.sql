CREATE DATABASE IF NOT EXISTS FinancialAnalystPractice;
USE FinancialAnalystPractice;

DROP TABLE IF EXISTS Financials;
DROP TABLE IF EXISTS Companies;

CREATE TABLE Companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(50),
    industry VARCHAR(30)
);

CREATE TABLE Financials (
    financial_id INT PRIMARY KEY,
    company_id INT,
    fiscal_year INT,
    revenue DECIMAL(10,2),
    net_profit DECIMAL(10,2),
    FOREIGN KEY (company_id) REFERENCES Companies(company_id)
);

INSERT INTO Companies VALUES
(1, 'Asian Paints', 'Paints'),
(2, 'Berger Paints', 'Paints'),
(3, 'Titan', 'Consumer'),
(4, 'HUL', 'Consumer'),
(5, 'Infosys', 'IT');

INSERT INTO Financials VALUES
(101, 1, 2024, 35000, 5000),
(102, 1, 2025, 33500, 3400),
(103, 2, 2024, 11000, 1000),
(104, 2, 2025, 12000, 1100),
(105, 3, 2024, 45000, 3200),
(106, 3, 2025, 48000, 3600),
(107, 4, 2024, 60000, 10000),
(108, 4, 2025, 62000, 10500),
(109, 5, 2024, 15000, 2600),
(110, 5, 2025, 17000, 3000);

select * from companies; 
select * from financials;

select f.financial_id, f.revenue, f.net_profit ,f.fiscal_year 
from financials f 
where f.revenue > (select avg(f.revenue) from financials f) ;

select f.revenue , f.net_profit 
from financials f 
where f.fiscal_year = 2025  and 
      f.revenue > (select avg(f.revenue) from financials f );
      
select f.financial_id, f.revenue, f.net_profit ,f.fiscal_year 
from financials f 
LEFT JOIN companies c 
ON f.company_id = c.company_id 
where industry = 'Paints' ;

select * 
from financials 
where company_id IN (select company_id  
from companies 
where industry = 'Paints') ;

select * 
from financials 
where net_profit > (select avg(net_profit) from financials );

select company_name
from companies 
where company_id IN (select company_id 
from financials
WHERE  fiscal_year = 2025 and
       revenue > 30000);
SELECT *
FROM Financials f
WHERE fiscal_year = 2025
AND revenue > (
    SELECT revenue
    FROM Financials
    WHERE company_id = f.company_id
    AND fiscal_year = 2024
);

SELECT company_name
FROM Companies c
WHERE EXISTS (
    SELECT 1
    FROM Financials f
    WHERE f.company_id = c.company_id
    AND f.net_profit > 9000
);

SELECT company_name
FROM Companies c
WHERE NOT EXISTS (
    SELECT 1
    FROM Financials f
    WHERE f.company_id = c.company_id
    AND f.fiscal_year = 2025
);
	
    
select *
from financials f 
where f.fiscal_year = 2025 
and f.net_profit >(select avg(net_profit) from financials 
where company_id = f.company_id );

SELECT *
FROM Financials f
WHERE revenue > (
    SELECT AVG(revenue)
    FROM Financials
    WHERE company_id = f.company_id
);


select * from companies; 
select * from financials;
