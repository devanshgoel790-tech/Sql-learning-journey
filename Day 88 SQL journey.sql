CREATE DATABASE SQL_Revision_Test;
USE SQL_Revision_Test;

DROP TABLE IF EXISTS Financials;
DROP TABLE IF EXISTS Companies;

CREATE TABLE Companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(50),
    industry VARCHAR(30),
    headquarters VARCHAR(30)
);

CREATE TABLE Financials (
    financial_id INT PRIMARY KEY,
    company_id INT,
    fiscal_year INT,
    revenue DECIMAL(12,2),
    expenses DECIMAL(12,2),
    net_profit DECIMAL(12,2)
);

INSERT INTO Companies VALUES
(1, 'Asian Paints', 'Paints', 'Mumbai'),
(2, 'Berger Paints', 'Paints', 'Kolkata'),
(3, 'Titan', 'Consumer', 'Bangalore'),
(4, 'HUL', 'Consumer', 'Mumbai'),
(5, 'Infosys', 'IT', 'Bangalore'),
(6, 'Wipro', 'IT', 'Bangalore'),
(7, 'Maruti Suzuki', 'Automobile', 'Delhi');

INSERT INTO Financials VALUES
(101, 1, 2024, 35000, 30000, 5000),
(102, 1, 2025, 33500, 30100, 3400),
(103, 2, 2024, 11000, 10000, 1000),
(104, 2, 2025, 12000, 10900, 1100),
(105, 3, 2024, 45000, 41800, 3200),
(106, 3, 2025, 48000, 44400, 3600),
(107, 4, 2024, 60000, 50000, 10000),
(108, 4, 2025, 62000, 51500, 10500),
(109, 5, 2024, 15000, 12400, 2600),
(110, 5, 2025, 17000, 14000, 3000),
(111, 7, 2025, 25000, 22000, 3000);

SELECT * FROM companies;
SELECT * FROM financials;

SELECT company_id,
       fiscal_year,
       revenue,
       net_profit
FROM financials
WHERE revenue BETWEEN 15000 AND 50000
ORDER BY revenue DESC;

SELECT fiscal_year,
       SUM(revenue)as total_revenue,
       AVG(revenue)as avg_revenue,
       MAX(revenue)as max_revenue,
       MIN(revenue)as min_revenue
FROM financials
GROUP BY fiscal_year
ORDER BY  fiscal_year;

SELECT company_id ,
      SUM(revenue)as total_revenue
FROM financials
GROUP BY company_id
HAVING total_revenue > 50000;

SELECT financial_id,
	   company_id,
	   net_profit,
CASE 
    WHEN net_profit >= 5000 THEN "High Profit"
    WHEN  net_profit BETWEEN 3000 AND 4999 THEN "Medium Profit"
    WHEN net_profit < 3000 THEN "Low Profit " 
    END AS Profit_category
FROM financials;

SELECT company_name,
      industry,
      fiscal_year,
      revenue,
      net_profit
FROM companies c
INNER JOIN financials f
ON c.company_id = f.company_id ;

SELECT c.*,
      f.*
FROM companies c
LEFT JOIN financials f 
ON c.company_id = f.company_id ;

SELECT f.*,
      c.company_name
FROM companies c
RIGHT JOIN financials f 
ON c.company_id = f.company_id ;


SELECT c.*,
      f.*
FROM companies c
LEFT JOIN financials f 
ON c.company_id = f.company_id 
UNION
SELECT c.*,
      f.*
FROM companies c
RIGHT JOIN financials f 
ON c.company_id = f.company_id ;

select company_id 
 FROM companies 
 UNION 
 SELECT company_id 
 FROM financials 
 ORDER BY company_id ASC;
 
select company_id 
 FROM companies 
 UNION ALL 
 SELECT company_id 
 FROM financials 
 ORDER BY company_id ASC;
 
 SELECT financial_id,
        company_id,
        net_profit
FROM financials
 WHERE net_profit> (SELECT avg(net_profit) FROM financials);
 
 SELECT c.company_name, f.revenue
 FROM companies c
 INNER JOIN financials f 
 ON c.company_id = f.company_id 
 WHERE f.fiscal_year = 2025 and
      f.revenue > (SELECT avg(revenue) FROM financials
      WHERE f.fiscal_year = 2025 )
ORDER BY revenue DESC 
LIMIT 2;