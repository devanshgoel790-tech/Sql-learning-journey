create database if not exists wholesale_electronic_shop;

use wholesale_electronic_shop;

CREATE TABLE sales_data (
    sales_id INT,
    salesperson_name VARCHAR(50),
    region VARCHAR(30),
    product_category VARCHAR(30),
    sale_date DATE,
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(12,2),
    commission_percent DECIMAL(5,2)
);

INSERT INTO sales_data VALUES
(1, 'Amit', 'North', 'Electronics', '2026-09-01', 5, 15000, 75000, 5),
(2, 'Priya', 'South', 'Clothing', '2026-09-01', 20, 500, 10000, 3),
(3, 'Rahul', 'East', 'Electronics', '2026-09-02', 2, 25000, 50000, 5),
(4, 'Neha', 'West', 'Furniture', '2026-09-02', 8, 5000, 40000, 4),
(5, 'Vikram', 'North', 'Clothing', '2026-09-03', 15, 800, 12000, 3),
(6, 'Sana', 'South', 'Electronics', '2026-09-03', 3, 20000, 60000, 5),
(7, 'Harsh', 'East', 'Furniture', '2026-09-04', 10, 4500, 45000, 4),
(8, 'Zara', 'West', 'Clothing', '2026-09-04', 25, 600, 15000, 3),
(9, 'Karan', 'North', 'Furniture', '2026-09-05', 6, 6000, 36000, 4),
(10, 'Isha', 'South', 'Electronics', '2026-09-05', 4, 18000, 72000, 5),
(11, 'Arjun', 'East', 'Clothing', '2026-09-06', 18, 700, 12600, 3),
(12, 'Divya', 'West', 'Furniture', '2026-09-06', 7, 5500, 38500, 4),
(13, 'Rohan', 'North', 'Electronics', '2026-09-07', 3, 22000, 66000, 5),
(14, 'Maya', 'South', 'Clothing', '2026-09-07', 22, 550, 12100, 3),
(15, 'Aditya', 'East', 'Electronics', '2026-09-08', 4, 16000, 64000, 5);

select * from sales_data;

select salesperson_name, product_category, total_amount from sales_data
where region = "North"
order by total_amount desc
limit 5;

select salesperson_name, quantity_sold, total_amount from sales_data
where product_category = "Electronics"
order by total_amount desc;

select count(quantity_sold) as number_of_sales, region  from sales_data
group by region
order by number_of_sales desc;

select count(unit_price * quantity_sold) as total_revenue , product_category from sales_data
Group by product_category
order by total_revenue desc
limit 1;

select avg(quantity_sold) as avg_quantity  , region from sales_data
group by region 
order by avg_quantity desc;

select salesperson_name , sum(total_amount)as total_sales_amount from sales_data 
where total_amount > 50000
group by salesperson_name
order by total_sales_amount desc;

select salesperson_name, sum(total_amount * commission_percent) / 100 as total_commission from sales_data
group by salesperson_name
order by total_commission desc
limit 5;

select region, avg(total_amount) as avg_sale_amount ,count(*) as number_of_sales from sales_data
group by region
having avg(total_amount) > 40000
order by avg_sale_amount desc;

select salesperson_name , sum(total_amount) as total_sales from sales_data
where region = "north"
group by salesperson_name
having sum(total_amount) < 99000
order by total_sales desc;



