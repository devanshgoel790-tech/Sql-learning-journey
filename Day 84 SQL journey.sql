CREATE DATABASE IF NOT EXISTS hr_finance_db;
USE hr_finance_db;

CREATE TABLE departments
 (dept_id INT PRIMARY KEY, 
 dept_name VARCHAR(30));
 
INSERT INTO departments VALUES 
(1,'Finance'),(2,'Sales'),
(3,'Operations'),(4,'HR');

CREATE TABLE employees 
(emp_id INT PRIMARY KEY, 
emp_name VARCHAR(30),
 dept_id INT,
 manager_id INT, 
 salary INT, 
 join_date DATE);
 
INSERT INTO employees VALUES
(1,'Arjun Mehta',1,NULL,150000,'2018-04-01'),
(2,'Neha Sharma',1,1,90000,'2019-06-15'),
(3,'Rohit Verma',1,1,85000,'2020-01-10'),
(4,'Priya Singh',2,1,120000,'2018-09-20'),
(5,'Karan Gupta',2,4,70000,'2021-03-05'),
(6,'Simran Kaur',2,4,65000,'2022-07-18'),
(7,'Amit Jain',3,1,110000,'2019-02-11'),
(8,'Pooja Rao',3,7,60000,'2021-11-23'),
(9,'Vikas Yadav',3,7,58000,'2023-05-02'),
(10,'Isha Malik',4,1,95000,'2020-08-30'),
(11,'Manish Tyagi',4,10,52000,'2023-01-16'),
(12,'Ritu Bansal',1,2,55000,'2024-02-12');

SELECT * FROM departments;
SELECT * FROM employees;

CREATE VIEW emp_dept AS
SELECT e.emp_id, e.emp_name, d.dept_name, e.salary
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

SELECT * FROM emp_dept;

CREATE TEMPORARY TABLE high_paid AS
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary >= 90000;

SELECT emp_name, salary FROM high_paid ORDER BY salary DESC;

WITH RECURSIVE nums(n) AS (
  SELECT 1
  UNION ALL
  SELECT n + 1 FROM nums WHERE n < 5
)
SELECT n FROM nums;

WITH RECURSIVE chain(emp_id, emp_name, lvl) AS (
  SELECT emp_id, emp_name, 1
  FROM employees
  WHERE manager_id IS NULL
  UNION ALL
  SELECT e.emp_id, e.emp_name, c.lvl + 1
  FROM employees e
  INNER JOIN chain c ON e.manager_id = c.emp_id
)
SELECT emp_name, lvl FROM chain ORDER BY lvl, emp_id;

SELECT emp_name, salary,
       NTILE(2) OVER (ORDER BY salary DESC) AS grp
FROM employees;

SELECT d.dept_name
FROM departments d
WHERE EXISTS (
  SELECT 1 FROM employees e
  WHERE e.dept_id = d.dept_id AND e.salary > 100000
)
ORDER BY d.dept_name;

SELECT emp_name, join_date, salary,
       ROUND(AVG(salary) OVER (ORDER BY join_date
             ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 0) AS moving_avg
FROM employees;

SELECT d.dept_name, SUM(e.salary) AS total_salary
FROM departments d
INNER JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING SUM(e.salary) > 200000
ORDER BY total_salary DESC;

SELECT e.emp_name, m.emp_name AS manager_name
FROM employees e
INNER JOIN employees m ON e.manager_id = m.emp_id
ORDER BY e.emp_id;

SELECT emp_name, salary
FROM employees e
WHERE salary > (
  SELECT AVG(salary) FROM employees
  WHERE dept_id = e.dept_id
)
ORDER BY salary DESC;