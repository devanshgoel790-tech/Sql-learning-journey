CREATE DATABASE IF NOT EXISTS branch_perf_db;
USE branch_perf_db;

DROP TABLE IF EXISTS buyers_2026;
DROP TABLE IF EXISTS buyers_2025;
DROP TABLE IF EXISTS advisors;
DROP TABLE IF EXISTS monthly_sales;
DROP TABLE IF EXISTS branches;

CREATE TABLE branches (
  branch_id   INT PRIMARY KEY,
  branch_name VARCHAR(30),
  city        VARCHAR(20)
);

CREATE TABLE monthly_sales (
  sale_id    INT PRIMARY KEY,
  branch_id  INT,
  sale_month DATE,
  sales      INT
);

CREATE TABLE advisors (
  advisor_id   INT PRIMARY KEY,
  advisor_name VARCHAR(30),
  branch_id    INT,
  ytd_sales    INT,
  target_text  VARCHAR(10)
);

CREATE TABLE buyers_2025 (
  client_name VARCHAR(30)
);

CREATE TABLE buyers_2026 (
  client_name VARCHAR(30)
);

INSERT INTO branches VALUES
(1, 'Central',     'Delhi'),
(2, 'Harbour',     'Mumbai'),
(3, 'Lakeside',    'Pune'),
(4, 'Orange City', 'Nagpur');

INSERT INTO monthly_sales VALUES
(1,  1, '2026-01-01', 90000),
(2,  1, '2026-02-01', 95000),
(3,  1, '2026-03-01', 110000),
(4,  1, '2026-04-01', 105000),
(5,  1, '2026-05-01', 125000),
(6,  1, '2026-06-01', 130000),
(7,  1, '2026-07-01', 120000),
(8,  1, '2026-08-01', 140000),
(9,  2, '2026-01-01', 70000),
(10, 2, '2026-02-01', 72000),
(11, 2, '2026-03-01', 68000),
(12, 2, '2026-04-01', 80000),
(13, 2, '2026-05-01', 85000),
(14, 2, '2026-06-01', 90000),
(15, 2, '2026-07-01', 95000),
(16, 2, '2026-08-01', 100000),
(17, 3, '2026-01-01', 50000),
(18, 3, '2026-02-01', 55000),
(19, 3, '2026-03-01', 52000),
(20, 3, '2026-04-01', 60000),
(21, 3, '2026-05-01', 58000),
(22, 3, '2026-06-01', 65000),
(23, 3, '2026-07-01', 70000),
(24, 3, '2026-08-01', 75000);

INSERT INTO advisors VALUES
(1,  'Aman Gill',     1, 780000, '700000'),
(2,  'Bhavna Rao',    1, 640000, '650000'),
(3,  'Chirag Jain',   1, 560000, '500000'),
(4,  'Divya Menon',   2, 910000, '800000'),
(5,  'Esha Kapoor',   2, 480000, '550000'),
(6,  'Farhan Syed',   2, 720000, '700000'),
(7,  'Gauri Nair',    3, 390000, '400000'),
(8,  'Harsh Vora',    3, 610000, '600000'),
(9,  'Ishita Bose',   3, 300000, '350000'),
(10, 'Jai Malhotra',  1, 850000, '800000'),
(11, 'Kavya Iyer',    2, 430000, '450000'),
(12, 'Lakshay Sood',  3, 520000, '500000');

INSERT INTO buyers_2025 VALUES
('Asha Traders'), ('Bright Foods'), ('Cobalt Tech'), ('Delta Textiles'),
('Echo Pharma'), ('Falcon Logistics'), ('Gamma Retail');

INSERT INTO buyers_2026 VALUES
('Bright Foods'), ('Cobalt Tech'), ('Echo Pharma'),
('Horizon Steel'), ('Ivory Hotels'), ('Gamma Retail');

SELECT * FROM advisors;
SELECT * FROM branches;
SELECT * FROM buyers_2025;
SELECT * FROM buyers_2026;
SELECT * FROM monthly_sales;

SELECT b.branch_name,
       SUM(s.sales) AS total_sales
FROM branches b
INNER JOIN monthly_sales s ON b.branch_id = s.branch_id
GROUP BY b.branch_id, b.branch_name
HAVING SUM(s.sales) > 600000
ORDER BY total_sales DESC;


SELECT advisor_name, ytd_sales,
       CASE
         WHEN ytd_sales >= 700000 THEN 'High'
         WHEN ytd_sales >= 500000 THEN 'Medium'
         ELSE 'Low'
       END AS performance
FROM advisors
ORDER BY ytd_sales DESC;


SELECT advisor_name, ytd_sales,
       CAST(target_text AS SIGNED) AS target
FROM advisors
WHERE ytd_sales > CAST(target_text AS SIGNED)
ORDER BY advisor_name;


SELECT b.branch_name
FROM branches b
WHERE EXISTS (
    SELECT 1
    FROM monthly_sales s
    WHERE s.branch_id = b.branch_id
      AND s.sales >= 100000
)
ORDER BY b.branch_name;


SELECT b.branch_name
FROM branches b
WHERE NOT EXISTS (
    SELECT 1
    FROM monthly_sales s
    WHERE s.branch_id = b.branch_id
);


SELECT advisor_name, ytd_sales,
       NTILE(4) OVER (ORDER BY ytd_sales DESC) AS quartile
FROM advisors
ORDER BY ytd_sales DESC;


SELECT advisor_name, ytd_sales,
       ROUND(PERCENT_RANK() OVER (ORDER BY ytd_sales), 2) AS pct_rank
FROM advisors
ORDER BY ytd_sales;


SELECT sale_month, sales,
       ROUND(AVG(sales) OVER (
           ORDER BY sale_month
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ), 2) AS moving_avg
FROM monthly_sales
WHERE branch_id = 1
ORDER BY sale_month;

SELECT client_name FROM buyers_2025
INTERSECT
SELECT client_name FROM buyers_2026
ORDER BY client_name;


SELECT client_name FROM buyers_2025
EXCEPT
SELECT client_name FROM buyers_2026
ORDER BY client_name;
