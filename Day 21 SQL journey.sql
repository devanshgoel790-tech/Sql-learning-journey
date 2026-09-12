create database wholesale_shop;

use wholesale_shop;

CREATE TABLE product_sales (
    sale_id INT,
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(30),
    region VARCHAR(30),
    month VARCHAR(20),
    units_sold INT,
    price_per_unit DECIMAL(10,2),
    revenue DECIMAL(12,2),
    profit DECIMAL(12,2),
    discount_percent DECIMAL(5,2)
);

INSERT INTO product_sales VALUES
(1, 101, 'Laptop Pro', 'Electronics', 'North', 'Sep-2026', 50, 95000, 4750000, 950000, 5),
(2, 102, 'Phone X', 'Electronics', 'South', 'Sep-2026', 120, 45000, 5400000, 1080000, 3),
(3, 103, 'Tablet Z', 'Electronics', 'East', 'Sep-2026', 80, 35000, 2800000, 560000, 2),
(4, 104, 'Headphones', 'Accessories', 'West', 'Sep-2026', 200, 5000, 1000000, 300000, 10),
(5, 105, 'Charger', 'Accessories', 'North', 'Sep-2026', 300, 1500, 450000, 180000, 8),
(6, 101, 'Laptop Pro', 'Electronics', 'South', 'Sep-2026', 45, 95000, 4275000, 855000, 5),
(7, 102, 'Phone X', 'Electronics', 'West', 'Sep-2026', 110, 45000, 4950000, 990000, 3),
(8, 103, 'Tablet Z', 'Electronics', 'North', 'Sep-2026', 70, 35000, 2450000, 490000, 2),
(9, 104, 'Headphones', 'Accessories', 'East', 'Sep-2026', 180, 5000, 900000, 270000, 10),
(10, 105, 'Charger', 'Accessories', 'South', 'Sep-2026', 250, 1500, 375000, 150000, 8),
(11, 101, 'Laptop Pro', 'Electronics', 'East', 'Aug-2026', 55, 95000, 5225000, 1045000, 5),
(12, 102, 'Phone X', 'Electronics', 'North', 'Aug-2026', 130, 45000, 5850000, 1170000, 3),
(13, 103, 'Tablet Z', 'Electronics', 'South', 'Aug-2026', 85, 35000, 2975000, 595000, 2),
(14, 104, 'Headphones', 'Accessories', 'West', 'Aug-2026', 190, 5000, 950000, 285000, 10),
(15, 105, 'Charger', 'Accessories', 'East', 'Aug-2026', 320, 1500, 480000, 192000, 8);

SELECT * FROM product_sales;

select product_name, region, revenue,  month from product_sales
where revenue > 4000000
order by revenue desc;

select product_name, category, units_sold, profit from product_sales
where category = "Electronics"
order by units_sold desc;

select product_name, units_sold, revenue from product_sales
where region = "North"
order by revenue desc
limit 5;

select product_name, discount_percent, revenue, profit
from product_sales
where discount_percent >" 5%"
order by discount_percent desc;

select category, sum(revenue) as  total_revenue from product_sales
group by category
order by total_revenue desc;

select region, sum(units_sold) as total_units_sold from product_sales 
group by region 
order by total_units_sold desc;

select category, sum(profit) as total_profit from product_sales
group by category
having sum(profit) > 2000000
order by total_profit desc;

select region , avg(revenue)as avg_revenue , count(*) as number_of_sales from product_sales
group by region
order by avg_revenue desc;

select product_name, sum(profit/ revenue * 100)as profit_margin_percentage from product_sales
group by product_name
order by profit_margin_percentage desc
limit 5;

select product_name as underperforming, category, region, profit, revenue from product_sales
where profit < 500000
order by profit asc;
