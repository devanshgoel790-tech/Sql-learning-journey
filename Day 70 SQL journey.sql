CREATE DATABASE sql_window_day1;

USE sql_window_day1;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    sales INT
);

INSERT INTO employees VALUES
(101, 'Asha', 'Finance', 90000),
(102, 'Rohan', 'Finance', 75000),
(103, 'Meera', 'Finance', 75000),
(104, 'Kabir', 'Finance', 60000),
(105, 'Nisha', 'HR', 80000),
(106, 'Arjun', 'HR', 80000),
(107, 'Pooja', 'HR', 55000),
(108, 'Dev', 'Sales', 95000),
(109, 'Isha', 'Sales', 70000),
(110, 'Vikram', 'Sales', 70000);

select * from employees;

select employee_name, department, sales,
 row_number()
 OVER( ORDER BY sales desc, employee_id) AS row_num
 FROM employees;  
 
 select employee_name, sales, 
 RANK()OVER(ORDER BY sales DESC) as sales_rank
 from employees;
 
 select employee_name, sales, 
 DENSE_RANK() 
 OVER(ORDER BY sales DESC) as dense_sales_rank
 from employees;

select employee_name, department, sales,
RANK() 
OVER(PARTITION BY department
     ORDER BY sales DESC
     ) AS department_rank
FROM employees;

select employee_name, department, sales,
DENSE_RANK() 
OVER(PARTITION BY department
     ORDER BY sales DESC
     ) AS department_rank
FROM employees;

select employee_name, department, sales,
ROW_NUMBER()
OVER(PARTITION BY department
     ORDER BY sales DESC, employee_id
     ) AS department_rank
FROM employees;

WITH ranked_employees AS(
 SELECT employee_name, department, sales,
 RANK()
 OVER(PARTITION BY department 
      order by sales DESC)AS sales_rank
      from employees)
select * from ranked_employees
where sales_rank =1 ;

WITH ranked_employees AS(
SELECT  employee_name, department, sales,
 DENSE_RANK()
 OVER(PARTITION BY department
     ORDER BY sales DESC) AS sales_rank
FROM employees)
SELECT * from ranked_employees
WHERE sales_rank <=2;

WITH employee_order AS(
  Select employee_name, department, sales,
  ROW_NUMBER()
  over(PARTITION BY department 
      ORDER BY sales DESC, employee_id ) as row_num
      from employees)
select * from employee_order
WHERE ROW_NUM = 2;

WITH department_ranking  AS(
SELECT  employee_name, department, sales,
 RANK()
 OVER(PARTITION BY department
     ORDER BY sales DESC) AS sales_rank
FROM employees)
SELECT * from  department_ranking
WHERE sales_rank <=3;



