CREATE DATABASE sql_window_day2;

USE sql_window_day2;

CREATE TABLE sales (
    transaction_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    month_name VARCHAR(20),
    sales_amount INT
);

INSERT INTO sales VALUES
(1, 'Asha', 'Finance', 'January', 50000),
(2, 'Rohan', 'Finance', 'January', 40000),
(3, 'Meera', 'Finance', 'February', 60000),
(4, 'Kabir', 'Finance', 'February', 30000),
(5, 'Nisha', 'HR', 'January', 25000),
(6, 'Arjun', 'HR', 'January', 35000),
(7, 'Pooja', 'HR', 'February', 45000),
(8, 'Dev', 'Sales', 'January', 70000),
(9, 'Isha', 'Sales', 'February', 55000),
(10, 'Vikram', 'Sales', 'February', 65000);

SELECT * FROM sales;

SELECT employee_name, 
	   sales_amount,
       SUM(sales_amount)OVER()as total_sales
from sales;


SELECT employee_name, 
       sales_amount,
       AVG(sales_amount)OVER()as avg_sales
from sales;

SELECT employee_name, 
       sales_amount,
       count(*)OVER()as total_transaction
from sales;

SELECT employee_name, 
       sales_amount,
       MAX(sales_amount)OVER(ORDER BY sales_amount DESC)as highest_sale
from sales;

SELECT employee_name, 
       sales_amount,
       MIN(sales_amount)OVER(ORDER BY sales_amount )as lowest_sale
from sales;

SELECT employee_name, 
       department,
       sales_amount,
       SUM(sales_amount)
       OVER(PARTITION BY department )AS department_total
       from sales;

select  employee_name, 
       department,
       sales_amount,
	   AVG(sales_amount)OVER(PARTITION BY department )AS department_avg
       from sales;
       

  select  employee_name, 
       department,
       sales_amount,
      SUM(sales_amount)OVER(PARTITION BY department)as department_total,
      AVG(sales_amount)OVER(partition by department)as department_avg
      from sales ;
      
SELECT transaction_id,
       employee_name,
       sales_amount,
       SUM(sales_amount) OVER(ORDER BY transaction_id 
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
from sales;

SELECT transaction_id,
       employee_name,
       department,
       sales_amount,
       SUM(sales_amount) OVER(PARTITION BY department ORDER BY transaction_id 
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
from sales;

select month_name, 
       transaction_id,
       sales_amount,
       SUM(sales_amount)OVER(PARTITION BY  month_name ORDER BY transaction_id  desc
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS monthly_running_total
        from sales;
        
SELECT employee_name,
       department,
       sales_amount,
       sum(sales_amount)OVER(PARTITION BY department )AS department_total_sales,
	   sum(sales_amount)OVER(PARTITION BY department) - sales_amount as differnce
        from sales;
        
SELECT employee_name, 
       department,
       sales_amount,
       sum(sales_amount)over(PARTITION BY department) as department_total_sales,
       avg(sales_amount)over(PARTITION BY department)as department_avg_sales,
       MIN(sales_amount)over(PARTITION BY department)as department_min_sales,
       MAX(sales_amount)over(PARTITION BY department)as department_max_sales,
       COUNT(*) OVER(PARTITION BY department )AS employee_count
       from sales ;
       
SELECT month_name,
       transaction_id ,
       employee_name, 
       sales_amount,
       SUM(sales_amount)OVER(PARTITION BY month_name) as monthly_toal_sales,
        avg(sales_amount)over(PARTITION BY month_name)as monthly_avg_sales,
        SUM(sales_amount)OVER(PARTITION  BY month_name ORDER BY transaction_id asc
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS monthly_running_total,
          COUNT(transaction_id) OVER(PARTITION BY month_name )AS transaction_count
        from sales
        ORDER BY transaction_id asc;
        
       

