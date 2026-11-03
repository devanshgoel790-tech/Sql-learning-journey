CREATE DATABASE fund_rank_db;
USE fund_rank_db;

CREATE TABLE funds (
  fund_id INT PRIMARY KEY,
  fund_name VARCHAR(40),
  category VARCHAR(20),
  amc VARCHAR(20),
  aum_cr INT,
  return_1y DECIMAL(4,1)
);

INSERT INTO funds VALUES
(1,'Alpha Bluechip','Equity','Alpha AMC',4200,18.5),
(2,'Alpha Midcap','Equity','Alpha AMC',2800,22.1),
(3,'Alpha Liquid','Debt','Alpha AMC',6100,6.8),
(4,'Beta Growth','Equity','Beta AMC',3500,18.5),
(5,'Beta Income','Debt','Beta AMC',5200,7.4),
(6,'Beta Balanced','Hybrid','Beta AMC',1900,12.2),
(7,'Gamma Value','Equity','Gamma AMC',2200,20.3),
(8,'Gamma Gilt','Debt','Gamma AMC',3000,7.4),
(9,'Gamma Hybrid','Hybrid','Gamma AMC',2600,13.9),
(10,'Delta Smallcap','Equity','Delta AMC',1500,25.6),
(11,'Delta Corporate Bond','Debt','Delta AMC',4100,6.2),
(12,'Delta Equity Saver','Hybrid','Delta AMC',1700,12.2),
(13,'Omega Flexicap','Equity','Omega AMC',3900,19.4),
(14,'Omega Short Term','Debt','Omega AMC',2400,6.8),
(15,'Omega Hybrid Adv','Hybrid','Omega AMC',2100,14.8),
(16,'Omega Index','Equity','Omega AMC',5000,15.7);

SELECT * FROM funds;

SELECT fund_name,
       aum_cr,
       ROW_NUMBER()OVER(ORDER BY aum_cr DESC) as serial_number
       FROM funds;

SELECT return_1y,
  RANK()OVER(ORDER BY  return_1y DESC) as highest_1yr_return
  FROM funds;
  
  SELECT return_1y,
  DENSE_RANK()OVER(ORDER BY  return_1y DESC) as highest_1yr_return
  FROM funds;
  
SELECT fund_name,
       category,
       aum_cr,
       RANK()OVER(PARTITION BY category ORDER BY aum_cr DESC)as largest_AUM
       FROM funds;
	
SELECT fund_name,
       category,
       return_1y,
       DENSE_RANK()OVER(PARTITION BY category ORDER BY return_1y DESC)as largest_AUM
       FROM funds;
	
SELECT amc,
       aum_cr,
       ROW_NUMBER()OVER( PARTITION BY amc ORDER BY  aum_cr DESC) as large_to_small_AUM
       FROM funds ;
       
SELECT fund_name, 
	category,
    return_1y,
    RANK()OVER(PARTITION BY category ORDER BY return_1y DESC)as highest_category_fund
    FROM funds;
    
WITH ranked AS (
  SELECT fund_name, category, return_1y,
         ROW_NUMBER() OVER (
           PARTITION BY category
           ORDER BY return_1y DESC, aum_cr DESC
         ) AS rn
  FROM funds
)
SELECT fund_name, category, return_1y
FROM ranked
WHERE rn <= 2
ORDER BY category, rn;

WITH ranked AS (
  SELECT fund_name, category, return_1y,
         RANK() OVER (
           PARTITION BY category
           ORDER BY return_1y DESC
         ) AS rk
  FROM funds
)
SELECT fund_name, category, return_1y
FROM ranked
WHERE rk = 1
ORDER BY category, fund_name;

SELECT * FROM funds;  


