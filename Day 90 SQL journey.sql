DROP DATABASE IF EXISTS sales_core_db;
CREATE DATABASE IF NOT EXISTS sales_core_db;
USE sales_core_db;

CREATE TABLE branches 
(branch_id INT PRIMARY KEY, 
branch_name VARCHAR(20),
 region VARCHAR(10));
INSERT INTO branches VALUES 
(1,'Meerut','North'),
(2,'Delhi','North'),
(3,'Mumbai','West'),
(4,'Pune','West'),
(5,'Chennai','South'),
(6,'Kochi','South');

CREATE TABLE sales 
(sale_id INT PRIMARY KEY, 
branch_id INT,
 sale_date DATE, 
 product VARCHAR(15), 
 amount INT, 
 status VARCHAR(10));
 
INSERT INTO sales VALUES
(1,1,'2026-09-05','Loan',500000,'Completed'),(2,1,'2026-09-18','Insurance',80000,'Completed'),
(3,1,'2026-10-07','Deposit',300000,'Completed'),(4,2,'2026-09-12','Loan',700000,'Completed'),
(5,2,'2026-10-15','Loan',400000,'Cancelled'),(6,2,'2026-10-28','Insurance',90000,'Completed'),
(7,3,'2026-09-09','Deposit',600000,'Completed'),(8,3,'2026-10-11','Loan',900000,'Completed'),
(9,3,'2026-11-03','Insurance',120000,'Completed'),(10,4,'2026-09-25','Loan',350000,'Completed'),
(11,4,'2026-10-19','Deposit',250000,'Completed'),(12,4,'2026-11-08','Loan',450000,'Cancelled'),
(13,5,'2026-09-30','Insurance',70000,'Completed'),(14,5,'2026-10-22','Deposit',200000,'Completed'),
(15,5,'2026-11-12','Loan',550000,'Completed'),(16,1,'2026-11-14','Loan',650000,'Completed');

SELECT * FROM branches;
SELECT * FROM sales;

SELECT 
    COALESCE(product, 'Grand Total') AS product,
    SUM(amount) AS total_amount
FROM sales
WHERE status = 'Completed'
GROUP BY product WITH ROLLUP;

SELECT 
    b.region,
    SUM(CASE WHEN s.product = 'Loan' THEN s.amount ELSE 0 END) AS Loan,
    SUM(CASE WHEN s.product = 'Insurance' THEN s.amount ELSE 0 END) AS Insurance,
    SUM(CASE WHEN s.product = 'Deposit' THEN s.amount ELSE 0 END) AS Deposit
FROM branches b
LEFT JOIN sales s 
    ON b.branch_id = s.branch_id AND s.status = 'Completed'
GROUP BY b.region;

WITH branch_totals AS (
    SELECT 
        b.branch_name,
        COALESCE(SUM(s.amount), 0) AS total_amount
    FROM branches b
    LEFT JOIN sales s 
        ON b.branch_id = s.branch_id AND s.status = 'Completed'
    GROUP BY b.branch_id, b.branch_name
)
SELECT 
    branch_name, 
    total_amount
FROM branch_totals
WHERE total_amount > (SELECT AVG(total_amount) FROM branch_totals)
ORDER BY total_amount DESC;

SELECT 
    branch_id,
    sale_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY branch_id 
        ORDER BY sale_date, sale_id
    ) AS running_total
FROM sales
WHERE status = 'Completed';

SELECT 
    sale_date,
    amount,
    DATEDIFF(
        sale_date, 
        LAG(sale_date) OVER (ORDER BY sale_date, sale_id)
    ) AS days_since_previous_sale
FROM sales
WHERE branch_id = 1;

SELECT *
FROM sales
WHERE status = 'Completed'
  AND amount > (
      SELECT AVG(amount) 
      FROM sales 
      WHERE status = 'Completed'
  )
ORDER BY amount DESC;

SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    COUNT(*) AS number_of_sales,
    SUM(amount) AS total_amount
FROM sales
WHERE status = 'Completed'
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sale_month;

SELECT DISTINCT b.branch_id, b.branch_name
FROM branches b
JOIN sales s ON b.branch_id = s.branch_id
WHERE s.status = 'Cancelled';

SELECT b.branch_id, b.branch_name
FROM branches b
LEFT JOIN sales s ON b.branch_id = s.branch_id
WHERE s.sale_id IS NULL;

SELECT DISTINCT product
FROM sales
WHERE branch_id IN (1, 3);

SELECT 
    UPPER(b.branch_name) AS branch_name_upper,
    LENGTH(b.branch_name) AS name_length,
    COALESCE(SUM(s.amount), 0) AS completed_total
FROM branches b
LEFT JOIN sales s 
    ON b.branch_id = s.branch_id AND s.status = 'Completed'
GROUP BY b.branch_id, b.branch_name;

SELECT 
    DATEDIFF(MAX(sale_date), MIN(sale_date)) AS days_between
FROM sales
WHERE status = 'Completed';