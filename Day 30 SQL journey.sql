create database if not exists E_Commerce_sales_data;
use E_Commerce_sales_data ;

CREATE TABLE sales_performance (
  sale_id INT PRIMARY KEY,
  salesperson_name VARCHAR(50),
  region VARCHAR(20),
  product_line VARCHAR(40),
  sale_amount DECIMAL(10,2),
  units_sold INT,
  commission_rate DECIMAL(5,2),
  customer_type VARCHAR(20),
  sale_date DATE,
  quarter VARCHAR(10)
);

INSERT INTO sales_performance VALUES
(1, 'Rahul Kumar', 'North', 'Electronics', 45000, 3, 5.0, 'Corporate', '2026-09-01', 'Q3'),
(2, 'Priya Singh', 'South', 'Software', 32000, 2, 8.0, 'Individual', '2026-09-02', 'Q3'),
(3, 'Amit Patel', 'East', 'Hardware', 28000, 4, 4.5, 'Corporate', '2026-09-01', 'Q3'),
(4, 'Rahul Kumar', 'North', 'Software', 55000, 5, 8.0, 'Corporate', '2026-09-03', 'Q3'),
(5, 'Neha Gupta', 'West', 'Electronics', 38000, 2, 5.0, 'Individual', '2026-09-02', 'Q3'),
(6, 'Priya Singh', 'South', 'Hardware', 22000, 3, 4.5, 'Individual', '2026-09-04', 'Q3'),
(7, 'Vikram Das', 'North', 'Electronics', 50000, 4, 5.0, 'Corporate', '2026-09-05', 'Q3'),
(8, 'Amit Patel', 'East', 'Software', 42000, 3, 8.0, 'Corporate', '2026-09-03', 'Q3'),
(9, 'Rahul Kumar', 'North', 'Hardware', 19000, 2, 4.5, 'Individual', '2026-09-06', 'Q3'),
(10, 'Neha Gupta', 'West', 'Software', 60000, 4, 8.0, 'Corporate', '2026-09-04', 'Q3'),
(11, 'Priya Singh', 'South', 'Electronics', 35000, 3, 5.0, 'Corporate', '2026-09-05', 'Q3'),
(12, 'Vikram Das', 'North', 'Software', 48000, 3, 8.0, 'Individual', '2026-09-06', 'Q3'),
(13, 'Amit Patel', 'East', 'Electronics', 41000, 2, 5.0, 'Corporate', '2026-09-07', 'Q3'),
(14, 'Rahul Kumar', 'North', 'Electronics', 52000, 3, 5.0, 'Individual', '2026-09-08', 'Q3'),
(15, 'Neha Gupta', 'West', 'Hardware', 25000, 4, 4.5, 'Individual', '2026-09-05', 'Q3'),
(16, 'Priya Singh', 'South', 'Software', 58000, 5, 8.0, 'Individual', '2026-09-07', 'Q3'),
(17, 'Vikram Das', 'North', 'Hardware', 18000, 2, 4.5, 'Corporate', '2026-09-08', 'Q3'),
(18, 'Amit Patel', 'East', 'Hardware', 30000, 5, 4.5, 'Individual', '2026-09-09', 'Q3'),
(19, 'Rahul Kumar', 'North', 'Software', 62000, 4, 8.0, 'Corporate', '2026-09-09', 'Q3'),
(20, 'Neha Gupta', 'West', 'Electronics', 44000, 3, 5.0, 'Corporate', '2026-09-10', 'Q3');

select * from sales_performance;

select salesperson_name, sum( sale_amount)as total_sales, sum(units_sold * commission_rate ) as total_commission from sales_performance
group by salesperson_name
order by sum(units_sold * commission_rate ) desc;

select product_line, avg( sale_amount) as avg_sale_amount from sales_performance
group by product_line
having count(sale_amount) > 2
order by avg_sale_amount desc
limit 1;

select salesperson_name , count(region) as region_count , sum(sale_amount) as total_sales from sales_performance
group by salesperson_name  
having count(region) >= 2
order by  sum(sale_amount) desc;

select region, sum(sale_amount)as total_sales, count(*) as transaction_count,  avg(units_sold)as avg_unit_per_sold from sales_performance
group by region 
having  sum(sale_amount) > 250000
      and  avg(units_sold) > 3;
      
 select customer_type, salesperson_name, sum(sale_amount) as total_sales from sales_performance
 group by customer_type , salesperson_name
 order by customer_type, sum(sale_amount) desc
 limit 1;
 
 select product_line, avg( commission_rate) as avg_commission_rate, sum(sale_amount) as total_sales_amount from sales_performance
 group by product_line
 having  avg( commission_rate) > "6%"
     and sum(sale_amount) > 200000;


select salesperson_name, region, 
                               sum(sale_amount) as total_sales_amount , 
                               count( product_line)as product_count, 
                               avg(commission_rate) as avg_commission_rate 
from sales_performance
 group by salesperson_name , region
 order by  sum(sale_amount) desc;
 
 
select salesperson_name, region,
       sum(sale_amount) as total_sales,
       count(distinct product_line) as product_count,
       avg(commission_rate) as avg_commission_rate
from sales_performance
group by salesperson_name, region
order by total_sales desc;
 
      





 





 