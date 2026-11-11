CREATE DATABASE IF NOT EXISTS invoice_db;
USE invoice_db;

DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS clients;

CREATE TABLE clients (
  client_id   INT PRIMARY KEY,
  client_name VARCHAR(30),
  city        VARCHAR(20)
);

CREATE TABLE invoices (
  invoice_id   INT PRIMARY KEY,
  client_id    INT,
  invoice_date DATE,
  due_date     DATE,
  paid_date    DATE,
  amount       INT
);

INSERT INTO clients VALUES
(1, 'Apex Traders',     'Delhi'),
(2, 'Bright Foods',     'Mumbai'),
(3, 'Cobalt Tech',      'Pune'),
(4, 'Delta Textiles',   'Surat'),
(5, 'Echo Pharma',      'Hyderabad'),
(6, 'Falcon Logistics', 'Chennai'),
(7, 'Gamma Retail',     'Jaipur'),
(8, 'Horizon Steel',    'Kolkata');

INSERT INTO invoices VALUES
(1, 1, '2026-06-03', '2026-07-03', '2026-07-01', 120000),
(2, 2, '2026-06-10', '2026-07-10', '2026-07-15', 85000),
(3, 3, '2026-06-18', '2026-08-02', '2026-08-02', 210000),
(4, 4, '2026-06-25', '2026-07-25', '2026-08-06', 64000),
(5, 1, '2026-07-02', '2026-08-01', '2026-07-27', 98000),
(6, 5, '2026-07-09', '2026-08-23', '2026-09-12', 175000),
(7, 6, '2026-07-15', '2026-08-14', '2026-08-14', 56000),
(8, 2, '2026-07-22', '2026-08-21', '2026-08-20', 132000),
(9, 7, '2026-07-29', '2026-09-12', NULL, 91000),
(10, 3, '2026-08-04', '2026-09-18', '2026-09-15', 240000),
(11, 4, '2026-08-11', '2026-09-10', '2026-10-05', 72000),
(12, 1, '2026-08-17', '2026-09-16', '2026-09-20', 115000),
(13, 8, '2026-08-24', '2026-09-23', NULL, 48000),
(14, 5, '2026-08-31', '2026-10-15', '2026-10-05', 160000),
(15, 6, '2026-09-05', '2026-10-05', '2026-10-23', 69000),
(16, 2, '2026-09-12', '2026-10-12', '2026-10-12', 101000),
(17, 7, '2026-09-19', '2026-11-03', NULL, 87000),
(18, 3, '2026-09-26', '2026-11-10', '2026-11-06', 255000),
(19, 1, '2026-10-01', '2026-10-31', NULL, 134000),
(20, 4, '2026-10-07', '2026-11-06', NULL, 78000),
(21, 5, '2026-10-13', '2026-11-27', NULL, 190000),
(22, 6, '2026-10-18', '2026-11-17', NULL, 61000),
(23, 2, '2026-10-22', '2026-11-21', NULL, 118000),
(24, 8, '2026-10-28', '2026-11-27', NULL, 52000);

SELECT * FROM invoices;
SELECT * FROM clients;
SELECT * FROM payments;
SELECT * FROM vendors;


SELECT invoice_id,
       YEAR(invoice_date)  AS inv_year,
       MONTH(invoice_date) AS inv_month
FROM invoices;


SELECT invoice_id, invoice_date, amount
FROM invoices
WHERE MONTH(invoice_date) = 9;


SELECT invoice_id,
       DATEDIFF(due_date, invoice_date) AS credit_days
FROM invoices;


SELECT invoice_id,
       DATEDIFF(paid_date, due_date) AS days_late
FROM invoices
WHERE paid_date IS NOT NULL
  AND DATEDIFF(paid_date, due_date) > 0
ORDER BY days_late DESC, invoice_id;


SELECT MONTH(invoice_date) AS inv_month,
       SUM(amount) AS total_amount
FROM invoices
GROUP BY MONTH(invoice_date)
ORDER BY inv_month;


SELECT invoice_id, due_date,
       DATEDIFF('2026-11-01', due_date) AS days_overdue
FROM invoices
WHERE paid_date IS NULL
  AND due_date < '2026-11-01'
ORDER BY days_overdue DESC;

SELECT invoice_id,
       DATE_FORMAT(invoice_date, '%d-%m-%Y') AS formatted_date
FROM invoices
WHERE client_id = 1
ORDER BY invoice_date;


SELECT c.client_name,
       ROUND(AVG(DATEDIFF(i.paid_date, i.due_date)), 1) AS avg_days_late
FROM clients c
INNER JOIN invoices i ON c.client_id = i.client_id
WHERE i.paid_date IS NOT NULL
GROUP BY c.client_id, c.client_name
HAVING AVG(DATEDIFF(i.paid_date, i.due_date)) > 0
ORDER BY avg_days_late DESC;


SELECT CASE
         WHEN DATEDIFF(paid_date, due_date) <= 0  THEN 'On time or early'
         WHEN DATEDIFF(paid_date, due_date) <= 15 THEN 'Late 1-15 days'
         ELSE 'Late 16+ days'
       END AS payment_status,
       COUNT(*) AS invoice_count
FROM invoices
WHERE paid_date IS NOT NULL
GROUP BY CASE
           WHEN DATEDIFF(paid_date, due_date) <= 0  THEN 'On time or early'
           WHEN DATEDIFF(paid_date, due_date) <= 15 THEN 'Late 1-15 days'
           ELSE 'Late 16+ days'
         END
ORDER BY invoice_count DESC, payment_status;


SELECT client_id, invoice_id, invoice_date,
       DATEDIFF(invoice_date,
                LAG(invoice_date) OVER (PARTITION BY client_id ORDER BY invoice_date)
       ) AS days_since_previous
FROM invoices
WHERE client_id IN (1, 2)
ORDER BY client_id, invoice_date;


   