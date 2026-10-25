
CREATE DATABASE case_practices;
USE case_practices;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(30),
    sales_amount DECIMAL(10,2),
    target_amount DECIMAL(10,2),
    region VARCHAR(30)
);

INSERT INTO sales VALUES
(1, 'Amit',  'Finance',  80000,  70000, 'North'),
(2, 'Priya', 'Sales',    95000, 100000, 'South'),
(3, 'Rahul', 'Finance',  60000,  50000, 'North'),
(4, 'Neha',  'Sales',   120000, 110000, 'West'),
(5, 'Karan', 'Marketing',40000,  60000, 'East'),
(6, 'Sneha', 'Finance', 100000, 100000, 'South'),
(7, 'Vikas', 'Marketing',75000,  70000, 'West'),
(8, 'Anjali','Sales',    55000,  80000, 'North'),
(9, 'Rohit', 'Finance',  45000,  50000, 'East'),
(10,'Pooja', 'Marketing',90000,  85000, 'South');

select * from sales;

select employee_name, sales_amount, target_amount,
CASE WHEN sales_amount >= target_amount THEN 'Achieved'
  ELSE 'Not Achieved' 
  END AS Performance_status
  from sales 
  order by Performance_status ;
  
  select employee_name, sales_amount ,
  CASE WHEN sales_amount >= 100000 then 'Excellent'
  WHEN sales_amount >= 70000 THEN 'Good'
  ELSE 'Needs Improvement'
  END AS sales_rating 
  from sales ;
  
Select employee_name, department, 
CASE 
WHEN department = 'Finance' THEN 'Finance Department' 
WHEN  department = 'Sales' THEN 'Revenue Department'
WHEN  department = 'Marketing' THEN 'promotional Department'
ELSE 'other'
END AS department_categiry 
from sales  ;

Select employee_name, sales_amount,
CASE
 WHEN sales_amount >= 100000 THEN '0.10'
 WHEN sales_amount>= 70000 THEN '0.07'
 ELSE '0.05'
 END AS commission_rate
 from sales ;
 
SELECT employee_name, department, sales_amount,target_amount,
CASE
WHEN sales_amount >= target_amount
AND sales_amount >= 100000 THEN 'High Performer'
WHEN sales_amount >= target_amount THEN 'Target Achieved'
WHEN department = 'Finance'THEN 'Finance - Below Target'
ELSE 'Target Missed'
END AS business_status
FROM sales;
  
  
select * from sales;