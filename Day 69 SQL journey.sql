CREATE DATABASE Financial_Analyst_Day69;
USE Financial_Analyst_Day69;

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50)
);

INSERT INTO Employees VALUES
(101, 'Amit', 'Finance'),
(102, 'Priya', 'Sales'),
(103, 'Rahul', 'Sales'),
(104, 'Neha', 'Finance'),
(105, 'Karan', 'IT'),
(106, 'Meera', 'Marketing');

CREATE TABLE Sales_Transactions (
    transaction_id INT PRIMARY KEY,
    employee_id INT,
    sale_date DATE,
    sales_amount DECIMAL(10,2)
);

INSERT INTO Sales_Transactions VALUES
(1, 101, '2026-01-05', 50000),
(2, 101, '2026-02-10', 60000),
(3, 102, '2026-01-12', 80000),
(4, 102, '2026-02-15', 90000),
(5, 103, '2026-01-20', 45000),
(6, 103, '2026-02-18', 55000),
(7, 104, '2026-01-25', 70000),
(8, 104, '2026-02-20', 65000),
(9, 105, '2026-01-28', 30000),
(10, 105, '2026-02-22', 35000),
(11, 102, '2026-03-05', 40000),
(12, 101, '2026-03-08', 25000);

select * from employees;
select * from sales_transactions;

select * from  sales_transactions
where sales_amount > 60000;

select employee_id, sum(s.sales_amount)as total_sales
from sales_transactions s 
GROUP BY employee_id;

SELECT e.employee_name, e.department, s.transaction_id , sum(s.sales_amount) as sales
from employees e
INNER JOIN sales_transactions s
ON e.employee_id = s.employee_id 
GROUP BY s.transaction_id ;

select e.employee_name, s.transaction_id
from employees e
Left join sales_transactions s
ON e.employee_id = s.employee_id
where s.transaction_id IS NULL;

select sum(s.sales_amount)as total_sales, e.department
 from employees e
Left join sales_transactions s
ON e.employee_id = s.employee_id
group by e.department 
HAVING sum(s.sales_amount) > 200000;

SELECT employee_id FROM employees
UNION
SELECT employee_id FROM sales_transactions;

SELECT employee_id FROM employees
UNION ALL
SELECT employee_id FROM sales_transactions;

SELECT e.employee_name, SUM(s.sales_amount) AS total_sales
FROM employees e
JOIN sales_transactions s
 ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.employee_name
HAVING SUM(s.sales_amount) > (SELECT AVG(emp_total) 
    FROM (SELECT SUM(sales_amount) AS emp_total
	FROM sales_transactions
	GROUP BY employee_id
    ) employee_totals
);

WITH EmployeeSales AS (
    SELECT employee_id, SUM(sales_amount) AS total_sales
    FROM sales_transactions
    GROUP BY employee_id
)
SELECT employee_id, total_sales
FROM EmployeeSales
WHERE total_sales > 130000;

SELECT 
    e.department, 
    SUM(s.sales_amount) AS total_sales, 
    AVG(s.sales_amount) AS avg_transaction_amount
FROM employees e
INNER JOIN sales_transactions s 
ON e.employee_id = s.employee_id
GROUP BY e.department;

