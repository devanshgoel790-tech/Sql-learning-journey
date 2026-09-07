CREATE DATABASE IF NOT EXISTS practice_subqueries;
USE practice_subqueries;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);
INSERT INTO departments VALUES
(1, 'HR', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'Sales', 'Chicago'),
(4, 'Marketing', 'New York');

-- Create Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10, 2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Insert Data into Employees
INSERT INTO employees VALUES
(101, 'Alice', 75000.00, 2),
(102, 'Bob', 55000.00, 1),
(103, 'Charlie', 85000.00, 2),
(104, 'David', 45000.00, 3),
(105, 'Emma',  60000.00, 3),
(106, 'Frank', 90000.00, 2),
(107, 'Grace', 50000.00, 4),
(108, 'Henry', 40000.00, 1);

select * from departments;

select * from employees;


select emp_name, salary from employees
where salary > (select avg(salary) from employees);

select SALARY, emp_name from employees
where dept_id = (select dept_id 
from departments 
where dept_NAME = "IT"
); 

 SELECT EMP_NAME, SALARY FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY FROM EMPLOYEES
ORDER BY SALARY ASC
LIMIT 1); 

SELECT emp_name, salary FROM employees
where dept_id in (SELECT dept_id FROM departments
where location = "NEW york" 
);


 select emp_name, salary from employees
where salary > 
(select avg(salary) from employees
where dept_id = (
select dept_id 
from departments
where dept_name = "sales")
);




