create database Bcompany;
use Bcompany;

CREATE TABLE departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(30),
  city VARCHAR(30)
);

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(30),
  dept_id INT,
  salary INT
);

CREATE TABLE expenses (
  expense_id INT PRIMARY KEY,
  emp_id INT,
  expense_type VARCHAR(20),
  amount INT,
  expense_date DATE
);

INSERT INTO departments VALUES
(1, 'Finance', 'Mumbai'),
(2, 'Sales', 'Delhi'),
(3, 'Marketing', 'Mumbai'),
(4, 'Legal', 'Pune');

INSERT INTO employees VALUES
(101, 'Amit', 1, 60000),
(102, 'Riya', 1, 75000),
(103, 'Sam', 2, 50000),
(104, 'Neha', 2, 55000),
(105, 'Karan', 3, 48000),
(106, 'Pooja', 3, 52000),
(107, 'Vikas', 1, 65000),
(108, 'Anjali', NULL, 45000);

INSERT INTO expenses VALUES
(1, 101, 'Travel', 4500, '2026-09-02'),
(2, 101, 'Food', 1200, '2026-09-05'),
(3, 102, 'Travel', 8000, '2026-09-10'),
(4, 102, 'Software', 6500, '2026-09-12'),
(5, 103, 'Food', 900, '2026-09-03'),
(6, 103, 'Travel', 5200, '2026-09-15'),
(7, 104, 'Software', 3000, '2026-09-18'),
(8, 105, 'Travel', 7000, '2026-09-20'),
(9, 105, 'Food', 1500, '2026-09-21'),
(10, 107, 'Software', 9000, '2026-09-25'),
(11, 107, 'Travel', 2500, '2026-09-27'),
(12, 108, 'Food', 700, '2026-09-28');

select * from departments;
select * from employees;
select * from expenses;

select emp_name, dept_name
from employees e
INNER JOIN departments d
on e.dept_id = d.dept_id;

select emp_name, salary, city
from employees e
INNER JOIN departments d
on e.dept_id = d.dept_id;

select emp_name, dept_name
from employees e
INNER JOIN departments d
on e.dept_id = d.dept_id
where dept_name = 'finance';

select emp_name, dept_name, salary
from employees e
INNER JOIN departments d
on e.dept_id = d.dept_id
order by  salary desc;

select emp_name, expense_type, amount
from employees e
INNER JOIN expenses ex
ON e.emp_id = ex.emp_id;

select emp_name, amount
from employees e
INNER JOIN expenses ex
on e.emp_id = ex.emp_id
where amount > 5000 ;

select emp_name, amount
from employees e
INNER JOIN expenses ex
on e.emp_id = ex.emp_id
where expense_type = 'Travel';

select emp_name, expense_type, amount
from employees e
INNER JOIN expenses ex
on e.emp_id = ex.emp_id
order by amount desc;

select emp_name, city 
from employees e
INNER JOIN DEPARTMENTS d
ON  e.dept_id = d.dept_id
where city ='mumbai';

select emp_name, expense_type, expense_date
from employees E
INNER JOIN expenses ex
on e.emp_id = ex.emp_id
where expense_date >='2026-09-15';

select * from departments;
select * from employees;
select * from expenses;



