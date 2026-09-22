create database B_company;
use B_company;

CREATE DATABASE employee_performance;
USE employee_performance;

CREATE TABLE employee_performance (
  employee_id INT PRIMARY KEY,
  employee_name VARCHAR(50),
  department VARCHAR(30),
  region VARCHAR(20),
  salary DECIMAL(10,2),
  performance_score INT,
  projects_completed INT,
  years_experience INT,
  bonus_amount DECIMAL(8,2),
  hire_date DATE
);

INSERT INTO employee_performance VALUES
(101, 'Rajesh Kumar', 'Sales', 'North', 45000, 85, 5, 4, 8000, '2022-01-15'),
(102, 'Priya Sharma', 'IT', 'South', 55000, 92, 8, 6, 12000, '2020-03-20'),
(103, 'Amit Patel', 'Sales', 'North', 42000, 78, 3, 2, 5000, '2024-02-10'),
(104, 'Neha Singh', 'IT', 'East', 58000, 88, 7, 5, 11000, '2021-06-15'),
(105, 'Vikram Das', 'HR', 'West', 48000, 82, 4, 3, 7000, '2023-04-01'),
(106, 'Deepak Roy', 'Sales', 'South', 46000, 80, 4, 3, 6000, '2023-05-10'),
(107, 'Anjali Verma', 'IT', 'North', 60000, 95, 9, 7, 14000, '2019-08-20'),
(108, 'Sanjay Gupta', 'Finance', 'East', 52000, 86, 6, 4, 9000, '2022-09-15'),
(109, 'Kavya Nair', 'HR', 'South', 47000, 81, 4, 2, 6500, '2023-11-01'),
(110, 'Rohit Jain', 'Finance', 'West', 54000, 89, 7, 5, 10000, '2021-12-10'),
(111, 'Sneha Iyer', 'IT', 'West', 59000, 93, 8, 6, 13000, '2020-07-15'),
(112, 'Arjun Reddy', 'Sales', 'East', 44000, 75, 2, 1, 4000, '2024-06-01'),
(113, 'Divya Malhotra', 'Finance', 'North', 51000, 84, 5, 3, 8500, '2022-10-20'),
(114, 'Varun Singh', 'HR', 'East', 49000, 83, 5, 2, 7500, '2023-02-10'),
(115, 'Pooja Agarwal', 'IT', 'South', 57000, 90, 8, 5, 12500, '2021-01-15');

select * from employee_performance;

select department,
                  count( employee_name) as count_employee, 
                  avg(salary)as avg_salary 
from employee_performance
group by department
order by  avg(salary) desc;

select department, 
                  avg( performance_score)as avg_performance_score , 
                  count(employee_name)as count_employee 
from employee_performance
group by department
having avg( performance_score) > 85
order by avg( performance_score) desc;

select region, 
		     count(employee_name), 
             avg(salary)as avg_salary ,
             sum(bonus_amount)as total_bonus_amount 
from employee_performance
group by region 
having sum(bonus_amount) > 25000
order by sum(bonus_amount) desc;

select department, 
                avg( performance_score)as avg_performance_score, 
                sum( projects_completed)as total_projects_completed,
                count(employee_name)as count_employee
from employee_performance
group by department
having avg( performance_score) > 82
  and sum( projects_completed) > 15
  and count(employee_name) >= 2;

  select region ,  
               avg(salary)as avg_salary ,
               avg( performance_score)as avg_performance_score,  
               count(employee_name)as count_employee, 
			   sum(bonus_amount)as total_bonus_amount ,
               avg(years_experience)as avg_years_experience
from employee_performance
group by region
having   avg(salary) > 50000 
    and  avg( performance_score) > 82
    and count(employee_name) >=2
order by avg_salary desc;

