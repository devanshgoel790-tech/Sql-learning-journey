CREATE DATABASE SQL_Practice_Set_2;

USE SQL_Practice_Set_2;

CREATE TABLE Companies2 (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(50),
    industry VARCHAR(50)
);

CREATE TABLE Financials2 (
    financial_id INT PRIMARY KEY,
    company_id INT,
    transaction_date DATE,
    revenue DECIMAL(12,2),
    expenses DECIMAL(12,2),
    net_profit DECIMAL(12,2),
    FOREIGN KEY (company_id)
        REFERENCES Companies2(company_id)
);

INSERT INTO Companies2 VALUES
(1, 'Asian Paints', 'Paints'),
(2, 'Berger Paints', 'Paints'),
(3, 'Titan', 'Consumer'),
(4, 'HUL', 'Consumer'),
(5, 'Infosys', 'IT'),
(6, 'Wipro', 'IT'),
(7, 'Maruti Suzuki', 'Automobile');
INSERT INTO Financials2 VALUES
(101, 1, '2024-01-15', 35000, 30000, 5000),
(102, 1, '2024-06-20', 38000, 32000, 6000),
(103, 1, '2025-01-10', 33500, 30100, 3400),
(104, 1, '2025-07-18', 42000, 35000, 7000),

(105, 2, '2024-02-12', 11000, 10000, 1000),
(106, 2, '2024-08-25', 13000, 11500, 1500),
(107, 2, '2025-02-14', 12000, 10900, 1100),
(108, 2, '2025-09-20', 15000, 12500, 2500),

(109, 3, '2024-03-10', 45000, 41800, 3200),
(110, 3, '2024-09-15', 47000, 43000, 4000),
(111, 3, '2025-03-12', 48000, 44400, 3600),
(112, 3, '2025-10-22', 52000, 47000, 5000),

(113, 4, '2024-04-05', 60000, 50000, 10000),
(114, 4, '2024-10-18', 65000, 53000, 12000),
(115, 4, '2025-04-08', 62000, 51500, 10500),
(116, 4, '2025-11-12', 68000, 55000, 13000),

(117, 5, '2024-05-11', 15000, 12400, 2600),
(118, 5, '2024-11-20', 18000, 14500, 3500),
(119, 5, '2025-05-16', 17000, 14000, 3000),
(120, 5, '2025-12-10', 22000, 17500, 4500),

(121, 6, '2024-06-14', 14000, 12000, 2000),
(122, 6, '2024-12-19', 16000, 13500, 2500),
(123, 6, '2025-06-17', 15500, 13200, 2300),
(124, 6, '2025-12-15', 19000, 15500, 3500),

(125, 7, '2024-07-21', 25000, 22000, 3000),
(126, 7, '2024-12-28', 28000, 24000, 4000),
(127, 7, '2025-07-23', 30000, 26000, 4000),
(128, 7, '2025-12-20', 35000, 29000, 6000);

SELECT * FROM companies2;
SELECT * FROM financials2;

SELECT f.*
FROM financials2 f
WHERE  YEAR(transaction_date) = 2025;

SELECT company_id,
       transaction_date,
       year(transaction_date)AS year,
       month(transaction_date)as month_number,
       monthname(transaction_date)AS month_name,
       DAY(transaction_date) AS day_of_month
FROM financials2;

SELECT financial_id,
	   transaction_date,
       DATEDIFF(curdate(), transaction_date)as number_of_days
FROM financials2;

SELECT *
FROM financials2
WHERE transaction_date BETWEEN '2025-01-01' AND '2025-06-30';

SELECT 
    company_id, 
    transaction_date, 
    net_profit
FROM financials2
WHERE transaction_date BETWEEN '2025-01-01' AND '2025-06-30';

SELECT *
FROM financials2
WHERE net_profit > (
    SELECT AVG(net_profit) 
    FROM financials2
);

SELECT 
    company_id, 
    SUM(revenue) AS total_revenue
FROM financials2
GROUP BY company_id
HAVING SUM(revenue) > (
    SELECT AVG(company_total)
    FROM (
        SELECT SUM(revenue) AS company_total
        FROM financials2
        GROUP BY company_id
    ) AS company_revenues
);

SELECT company_name
FROM companies2 c
WHERE EXISTS (
    SELECT 1
    FROM financials2 f
    WHERE f.company_id = c.company_id 
      AND f.net_profit > 5000
);

SELECT 
    financial_id,
    company_id,
    net_profit,
    CASE 
        WHEN net_profit >= 5000 THEN 'High Profit'
        WHEN net_profit >= 3000 AND net_profit <= 4999 THEN 'Medium Profit'
        ELSE 'Low Profit'
    END AS profit_category
FROM financials2;

SELECT 
    company_id,
    transaction_date,
    revenue,
    CASE 
        WHEN revenue > 50000 THEN 'Large Revenue'
        WHEN revenue >= 20000 AND revenue <= 50000 THEN 'Medium Revenue'
        ELSE 'Small Revenue'
    END AS revenue_category
FROM financials2;

SELECT 
    company_id,
    revenue,
    net_profit,
    ROUND((net_profit * 100.0) / NULLIF(revenue, 0), 2) AS profit_margin,
    CASE 
        WHEN (net_profit * 100.0) / NULLIF(revenue, 0) > 15 THEN 'Strong Margin'
        WHEN (net_profit * 100.0) / NULLIF(revenue, 0) >= 8 THEN 'Average Margin'
        ELSE 'Weak Margin'
    END AS margin_category
FROM financials2;

SELECT 
    company_id,
    transaction_date,
    revenue,
    SUM(revenue) OVER (
        PARTITION BY company_id 
        ORDER BY transaction_date
    ) AS running_total
FROM financials2
ORDER BY company_id, transaction_date;

WITH CompanyRevenue AS (
    SELECT 
        c.company_name,
        SUM(f.revenue) AS total_revenue
    FROM companies2 c
    INNER JOIN financials2 f
    ON c.company_id = f.company_id
    GROUP BY c.company_id, c.company_name
)
SELECT 
    company_name,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS revenue_dense_rank
FROM CompanyRevenue
ORDER BY total_revenue DESC;

SELECT 
    company_id,
    transaction_date,
    revenue AS current_revenue,
    LAG(revenue) OVER (
        PARTITION BY company_id 
        ORDER BY transaction_date
    ) AS previous_revenue,
    LEAD(revenue) OVER (
        PARTITION BY company_id 
        ORDER BY transaction_date
    ) AS next_revenue
FROM financials2
ORDER BY company_id, transaction_date;

SELECT
    company_id,
    transaction_date,
    revenue,
    FIRST_VALUE(revenue) OVER (
        PARTITION BY company_id
        ORDER BY transaction_date
    ) AS first_transaction_revenue,
    LAST_VALUE(revenue) OVER (
        PARTITION BY company_id
        ORDER BY transaction_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_transaction_revenue
FROM financials2
ORDER BY company_id, transaction_date;

       