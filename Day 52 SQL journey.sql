DROP DATABASE IF EXISTS budget_db;
CREATE DATABASE budget_db;
USE budget_db;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30),
    annual_budget INT
);

CREATE TABLE vendors (
    vendor_id INT PRIMARY KEY,
    vendor_name VARCHAR(30),
    city VARCHAR(30)
);

CREATE TABLE expenses (
    expense_id INT PRIMARY KEY,
    dept_id INT,
    vendor_id INT,
    category VARCHAR(20),
    amount INT,
    expense_date DATE,
    status VARCHAR(10)
);

INSERT INTO departments VALUES
(1, 'Sales',     500000),
(2, 'Marketing', 150000),
(3, 'IT',        330000),
(4, 'HR',        200000),
(5, 'Finance',    80000),
(6, 'Legal',     150000),
(7, 'Admin',     100000);

INSERT INTO vendors VALUES
(1, 'CloudNest',  'Bangalore'),
(2, 'PrintPro',   'Delhi'),
(3, 'AdWave',     'Mumbai'),
(4, 'TravelEase', 'Delhi'),
(5, 'OfficeMart', 'Noida'),
(6, 'SoftServe',  'Pune'),
(7, 'DataCore',   'Chennai');

INSERT INTO expenses VALUES
(1,  1, 3,    'Advertising', 45000,  '2026-07-05', 'Approved'),
(2,  1, 4,    'Travel',      18000,  '2026-07-12', 'Approved'),
(3,  1, 4,    'Travel',      22000,  '2026-08-03', 'Approved'),
(4,  1, 3,    'Advertising', 60000,  '2026-08-20', 'Rejected'),
(5,  2, 3,    'Advertising', 85000,  '2026-07-08', 'Approved'),
(6,  2, 3,    'Advertising', 70000,  '2026-08-14', 'Approved'),
(7,  2, 2,    'Office',      12000,  '2026-08-25', 'Approved'),
(8,  2, 4,    'Travel',      30000,  '2026-09-02', 'Pending'),
(9,  3, 1,    'Software',    120000, '2026-07-02', 'Approved'),
(10, 3, 1,    'Software',    95000,  '2026-08-09', 'Approved'),
(11, 3, 5,    'Office',      25000,  '2026-08-18', 'Approved'),
(12, 3, NULL, 'Training',    40000,  '2026-08-28', 'Approved'),
(13, 4, 5,    'Office',      15000,  '2026-07-20', 'Approved'),
(14, 4, NULL, 'Training',    20000,  '2026-08-11', 'Approved'),
(15, 4, 2,    'Office',      9000,   '2026-09-04', 'Rejected'),
(16, 5, 1,    'Software',    55000,  '2026-07-15', 'Approved'),
(17, 5, 5,    'Office',      18000,  '2026-09-06', 'Pending'),
(18, 5, 4,    'Travel',      14000,  '2026-08-22', 'Approved'),
(19, 3, 1,    'Software',    150000, '2026-09-09', 'Pending'),
(20, 1, 5,    'Office',      8000,   '2026-09-10', 'Approved');


select d.dept_name, d.annual_budget,
    SUM(CASE WHEN e.status = 'Approved' then e.amount else 0 END) AS total_approved,
    SUM(CASE WHEN e.status = 'Rejected' then 1 else 0 END) AS rejected_count,
    CASE 
        WHEN SUM(CASE WHEN e.status = 'Approved' then e.amount else 0 END) > d.annual_budget then 'Over Budget'
        WHEN SUM(CASE WHEN e.status = 'Approved' then e.amount else 0 END) >= 0.8 * d.annual_budget then 'Near Limit'
        ELSE 'Safe'
    END as budget_status
from departments d
LEFT JOIN expenses e ON d.dept_id = e.dept_id
GROUP BY d.dept_name, d.annual_budget
HAVING SUM(CASE WHEN e.status = 'Approved' then e.amount else 0 END) > 50000
ORDER BY total_approved desc
LIMIT 3;
     
SELECT v.vendor_name,
  SUM(CASE WHEN e.status = 'Approved' THEN e.amount ELSE 0 END) AS total_approved,
  COUNT(e.expense_id) AS expense_count,
  CASE WHEN COUNT(e.expense_id) = 0 THEN 'Unused'
       WHEN COUNT(e.expense_id) <= 2 THEN 'Light'
       ELSE 'Active' END AS vendor_activity
FROM vendors v
LEFT JOIN expenses e ON v.vendor_id = e.vendor_id
GROUP BY v.vendor_id, v.vendor_name
ORDER BY total_approved DESC, v.vendor_name;


select * from departments;
select * from vendors;
select * from expenses;