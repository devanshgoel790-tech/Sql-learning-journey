CREATE DATABASE department_sales;
USE department_sales;

CREATE TABLE department_sales (
  sale_id INT PRIMARY KEY,
  department VARCHAR(30),
  employee_name VARCHAR(50),
  region VARCHAR(20),
  product_type VARCHAR(30),
  quantity_sold INT,
  sale_amount DECIMAL(10,2),
  cost_amount DECIMAL(9,2),
  transaction_date DATE,
  customer_type VARCHAR(20),
  performance_rating INT
);

INSERT INTO department_sales VALUES
(1, 'Sales', 'Rajesh', 'North', 'Electronics', 15, 450000, 180000, '2026-09-01', 'Premium', 95),
(2, 'Sales', 'Priya', 'South', 'Software', 8, 280000, 98000, '2026-09-02', 'Standard', 88),
(3, 'IT', 'Amit', 'East', 'Hardware', 12, 320000, 145000, '2026-09-01', 'Premium', 92),
(4, 'Sales', 'Neha', 'West', 'Electronics', 18, 520000, 195000, '2026-09-03', 'Premium', 94),
(5, 'HR', 'Vikram', 'North', 'Software', 6, 210000, 72000, '2026-09-04', 'Standard', 85),
(6, 'IT', 'Deepak', 'South', 'Hardware', 14, 380000, 172000, '2026-09-03', 'Premium', 91),
(7, 'Finance', 'Anjali', 'East', 'Services', 5, 195000, 88000, '2026-09-05', 'Standard', 87),
(8, 'Sales', 'Sanjay', 'North', 'Electronics', 22, 620000, 248000, '2026-09-04', 'Premium', 96),
(9, 'IT', 'Kavya', 'West', 'Hardware', 16, 410000, 185000, '2026-09-05', 'Premium', 93),
(10, 'HR', 'Rohit', 'South', 'Software', 4, 155000, 60000, '2026-09-06', 'Basic', 82),
(11, 'Finance', 'Sneha', 'North', 'Services', 7, 225000, 102000, '2026-09-07', 'Premium', 89),
(12, 'Sales', 'Arjun', 'East', 'Electronics', 13, 385000, 154000, '2026-09-06', 'Premium', 90),
(13, 'IT', 'Divya', 'South', 'Hardware', 18, 475000, 214000, '2026-09-07', 'Premium', 94),
(14, 'Finance', 'Varun', 'West', 'Services', 9, 285000, 128000, '2026-09-09', 'Standard', 86),
(15, 'Sales', 'Pooja', 'North', 'Electronics', 19, 540000, 216000, '2026-09-08', 'Premium', 95),
(16, 'HR', 'Kumar', 'East', 'Software', 6, 220000, 84000, '2026-09-10', 'Standard', 84),
(17, 'IT', 'Priyanka', 'North', 'Hardware', 13, 355000, 160000, '2026-09-09', 'Standard', 88),
(18, 'Finance', 'Arun', 'South', 'Services', 10, 310000, 140000, '2026-09-11', 'Premium', 91),
(19, 'Sales', 'Meera', 'West', 'Electronics', 16, 480000, 192000, '2026-09-10', 'Premium', 93),
(20, 'IT', 'Harsh', 'East', 'Hardware', 17, 445000, 200000, '2026-09-12', 'Premium', 92);


select * from department_sales;

select department,
                 sum(sale_amount)as total_sale_amount,
                 avg( performance_rating)as avg_performance_rating,
                 count( distinct  employee_name)as employee_count
from department_sales
group by department
having total_sale_amount > 2000000
  and avg_performance_ratig > 87
  and employee_count >= 3
order by  sum( sale_amount) desc;


select department,
          product_type,
          sum(quantity_sold)as total_quantity,
          avg( sale_amount)as avg_sale_amount,
          count(*)as transaction_count
from department_sales
group by department, product_type
having sum(quantity_sold) > 80
  and  avg( sale_amount) > 250000
  and  count(*) >=3
order by  total_quantity desc;

select region, department,
                       sum(sale_amount)as total_revenue,
                       sum(cost_amount)as total_cost,
                       ( sum(sale_amount) - sum(cost_amount))as total_profit,
                       avg(performance_rating)as avg_rating,
                       count( employee_name)as employee_count,
                       count(customer_type)as customer_type_count
from department_sales
group by region, department
having  total_revenue > 1500000
   and  total_cost > 600000
   and avg_rating > 86
order by total_profit desc;

select department,
                  sum( sale_amount) as total_sales,
                  sum(quantity_sold )as total_quantity,
                  avg(performance_rating)as avg_rating,
                  (sum(sale_amount)/ sum(cost_amount))as cost_efficiency,
                  count(distinct employee_name)as employee_count,
                  count(case 
							when performance_rating > 90 then 1 end)as high_performance_count
from department_sales
group by department
having total_sales > 1800000
  and avg_rating > 87
  and employee_count >= 2
order by total_sales desc;


select department, region,
                         sum(sale_amount)as total_revenue,
                         sum(cost_amount)as total_cost,
                         (sum(sale_amount) - sum(cost_amount))as gross_profit,
                        ( (sum(sale_amount) - sum(cost_amount)) / sum(sale_amount)) * 100 as profit_margin_percentage,
                         avg(performance_rating)as avg_rating,
						 count(distinct employee_name)as employee_count,
                         sum(case 
                                  when customer_type = 'Premium' then 1  end) as premium_customer_count,
						sum(sale_amount) / count(DISTINCT EMPLOYEE_name)as revenue_per_employee
from department_sales
group by department, region
having avg_rating >= 88
  and total_revenue > 1400000
  and profit_margin_percentage > 58
  and employee_count >=2
order by gross_profit desc;                      
                           