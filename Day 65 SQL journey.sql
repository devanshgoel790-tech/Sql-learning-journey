CREATE DATABASE budget_cte_db;
USE budget_cte_db;

CREATE TABLE departments
 (dept_id INT PRIMARY KEY, 
 dept_name VARCHAR(30));
 
CREATE TABLE budgets 
(dept_id INT PRIMARY KEY,
 budget_amount INT);
 
CREATE TABLE expenses 
(expense_id INT PRIMARY KEY,
 dept_id INT,
 category VARCHAR(20),
 amount INT);

INSERT INTO departments VALUES
(1,'Sales'),
(2,'Marketing'),
(3,'HR'),
(4,'IT'),
(5,'Finance'),
(6,'Operations');

INSERT INTO budgets VALUES
(1,500000),
(2,300000),
(3,150000),
(4,400000),
(5,120000),
(6,600000);

INSERT INTO expenses VALUES
(1,1,'Travel',120000),
(2,1,'Salary',300000),
(3,1,'Software',60000),
(4,2,'Advertising',180000),
(5,2,'Events',90000),
(6,2,'Travel',50000),
(7,3,'Training',40000),
(8,3,'Salary',100000),
(9,4,'Software',150000),
(10,4,'Hardware',200000),
(11,4,'Salary',90000),
(12,5,'Salary',80000),
(13,5,'Software',25000),
(14,6,'Salary',350000),
(15,6,'Travel',90000),
(16,6,'Hardware',210000);

SELECT * from budgets;
SELECT * from departments;
SELECT * from expenses;

WITH dept_spend AS (
    SELECT dept_id, SUM(amount) AS total_spent
    FROM expenses
    GROUP BY dept_id
)
SELECT d.dept_name, ds.total_spent
FROM dept_spend ds
INNER JOIN departments d ON d.dept_id = ds.dept_id
ORDER BY ds.total_spent DESC;

WITH dept_spend AS (
    SELECT dept_id, SUM(amount) AS total_spent
    FROM expenses
    GROUP BY dept_id
)
SELECT d.dept_name, b.budget_amount, ds.total_spent
FROM dept_spend ds
INNER JOIN departments d ON d.dept_id = ds.dept_id
INNER JOIN budgets b ON b.dept_id = ds.dept_id
WHERE ds.total_spent > b.budget_amount
ORDER BY ds.total_spent DESC;

WITH dept_spend AS (
    SELECT dept_id, SUM(amount) AS total_spent
    FROM expenses
    GROUP BY dept_id
)
SELECT d.dept_name, ds.total_spent - b.budget_amount AS over_amount
FROM dept_spend ds
INNER JOIN departments d ON d.dept_id = ds.dept_id
INNER JOIN budgets b ON b.dept_id = ds.dept_id
WHERE ds.total_spent > b.budget_amount
ORDER BY over_amount DESC;

WITH dept_spend AS (
    SELECT dept_id, SUM(amount) AS total_spent
    FROM expenses
    GROUP BY dept_id
)
SELECT d.dept_name, ds.total_spent
FROM dept_spend ds
INNER JOIN departments d ON d.dept_id = ds.dept_id
WHERE ds.total_spent > (SELECT AVG(total_spent) FROM dept_spend)
ORDER BY ds.total_spent DESC;

WITH dept_lines AS (
    SELECT dept_id, COUNT(*) AS line_count, SUM(amount) AS total_spent
    FROM expenses
    GROUP BY dept_id
)
SELECT d.dept_name, dl.line_count, dl.total_spent
FROM dept_lines dl
INNER JOIN departments d ON d.dept_id = dl.dept_id
WHERE dl.line_count > 2
ORDER BY dl.total_spent DESC;








