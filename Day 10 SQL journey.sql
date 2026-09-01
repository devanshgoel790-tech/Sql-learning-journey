CREATE DATABASE IF NOT EXISTS fpna_practice;
USE fpna_practice;


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10, 2),
    hire_date DATE
);

INSERT INTO employees VALUES
(101, 'Rajesh Kumar', 'Finance', 75000, '2023-01-15'),
(102, 'Priya Singh', 'Sales', 65000, '2023-03-20'),
(103, 'Amit Patel', 'Finance', 70000, '2022-06-10'),
(104, 'Neha Sharma', 'Sales', 68000, '2024-01-05'),
(105, 'Vikram Desai', 'Operations', 72000, '2023-09-12');


CREATE TABLE budget (
    budget_id INT PRIMARY KEY,
    department VARCHAR(30),
    month_year VARCHAR(10),
    budgeted_amount DECIMAL(12, 2)
);

INSERT INTO budget VALUES
(1, 'Finance', '2026-08', 50000),
(2, 'Sales', '2026-08', 80000),
(3, 'Operations', '2026-08', 60000),
(4, 'Finance', '2026-09', 55000),
(5, 'Sales', '2026-09', 85000),
(6, 'Operations', '2026-09', 62000);


CREATE TABLE expenses (
    expense_id INT PRIMARY KEY,
    employee_id INT,
    department VARCHAR(30),
    amount DECIMAL(10, 2),
    expense_date DATE,
    category VARCHAR(30)
);

INSERT INTO expenses VALUES
(1001, 101, 'Finance', 5000, '2026-08-05', 'Software'),
(1002, 102, 'Sales', 8000, '2026-08-10', 'Travel'),
(1003, 103, 'Finance', 3500, '2026-08-15', 'Training'),
(1004, 104, 'Sales', 6500, '2026-08-20', 'Travel'),
(1005, 105, 'Operations', 7000, '2026-08-25', 'Maintenance'),
(1006, 101, 'Finance', 4000, '2026-09-05', 'Software'),
(1007, 102, 'Sales', 9000, '2026-09-12', 'Travel'),
(1008, 103, 'Finance', 2500, '2026-09-18', 'Training'),
(1009, 104, 'Sales', 7500, '2026-09-22', 'Travel'),
(1010, 105, 'Operations', 6500, '2026-09-28', 'Maintenance');


SELECT * FROM employees;
SELECT * FROM budget;
SELECT * FROM expenses;

SELECT department, SUM(amount)
FROM expenses
WHERE expense_date LIKE '2026-08%'
GROUP BY department;



SELECT budget.department, 
 SUM(expenses.amount) AS actual_expenses
FROM budget 
JOIN expenses ON budget.department = expenses.department
WHERE  expenses.expense_date LIKE '2026-08%'
GROUP BY budget.department;