create database if not exists Customer_Revenue_Analytics;
use customer_revenue_analytics;

CREATE TABLE customer_transactions (
  transaction_id INT PRIMARY KEY,
  customer_id INT,
  customer_segment VARCHAR(30),
  product_category VARCHAR(40),
  transaction_date DATE,
  revenue DECIMAL(10,2),
  units_sold INT,
  customer_lifetime_value DECIMAL(12,2),
  repeat_customer BOOLEAN,
  region VARCHAR(20),
  channel VARCHAR(20)
);

INSERT INTO customer_transactions VALUES
(1, 101, 'Premium', 'Electronics', '2026-09-01', 5000, 2, 25000, 1, 'North', 'Online'),
(2, 102, 'Standard', 'Clothing', '2026-09-01', 1200, 5, 8000, 0, 'South', 'Retail'),
(3, 101, 'Premium', 'Electronics', '2026-09-03', 4500, 1, 25000, 1, 'North', 'Online'),
(4, 103, 'Budget', 'Home', '2026-09-02', 800, 8, 3000, 0, 'East', 'Online'),
(5, 102, 'Standard', 'Electronics', '2026-09-04', 2800, 2, 8000, 1, 'South', 'Retail'),
(6, 104, 'Premium', 'Clothing', '2026-09-05', 3500, 3, 20000, 1, 'West', 'Online'),
(7, 101, 'Premium', 'Home', '2026-09-06', 6000, 4, 25000, 1, 'North', 'Online'),
(8, 105, 'Budget', 'Electronics', '2026-09-02', 1500, 6, 4000, 0, 'East', 'Retail'),
(9, 103, 'Budget', 'Clothing', '2026-09-05', 600, 10, 3000, 1, 'East', 'Online'),
(10, 106, 'Standard', 'Home', '2026-09-03', 2200, 5, 9000, 0, 'South', 'Retail'),
(11, 104, 'Premium', 'Electronics', '2026-09-07', 5500, 2, 20000, 1, 'West', 'Online'),
(12, 102, 'Standard', 'Home', '2026-09-06', 1800, 3, 8000, 1, 'South', 'Online'),
(13, 107, 'Budget', 'Clothing', '2026-09-04', 700, 12, 2500, 0, 'North', 'Retail'),
(14, 101, 'Premium', 'Clothing', '2026-09-08', 3200, 2, 25000, 1, 'North', 'Retail'),
(15, 108, 'Standard', 'Electronics', '2026-09-05', 3000, 3, 10000, 0, 'West', 'Online'),
(16, 109, 'Premium', 'Home', '2026-09-07', 7000, 5, 22000, 1, 'East', 'Online'),
(17, 105, 'Budget', 'Home', '2026-09-06', 900, 9, 4000, 1, 'East', 'Retail'),
(18, 103, 'Budget', 'Electronics', '2026-09-08', 1200, 7, 3000, 1, 'East', 'Online'),
(19, 106, 'Standard', 'Clothing', '2026-09-07', 1600, 4, 9000, 1, 'South', 'Retail'),
(20, 110, 'Premium', 'Clothing', '2026-09-09', 4000, 3, 19000, 0, 'West', 'Online');

select * from customer_transactions;

select customer_segment, sum(revenue * units_sold) as total_revenue from customer_transactions
group by customer_segment
order by  sum(revenue * units_sold) desc;

select product_category, avg(revenue * units_sold)as avg_revenue from customer_transactions
group by product_category
having count(*) >= 2
order by avg_revenue desc;


select repeat_customer,customer_id,
                                count(transaction_id ) as transactions_count,
                                sum(revenue * units_sold) as total_revenue, 
                                avg( customer_lifetime_value) as avg_transaction_value 
from customer_transactions
where repeat_customer =1 and customer_segment = "Premium"
group by repeat_customer, customer_id
order by sum(revenue * units_sold) desc;

select region,
              avg( customer_lifetime_value) as avg_customer_lifetime_value,
              count( transaction_id)As  transaction_id
 from customer_transactions
 group by region
 having  avg( customer_lifetime_value) > 10000 and count( transaction_id) > 3
order by avg( customer_lifetime_value) desc;

select customer_segment, 
					    sum(revenue * units_sold) as total_revenue,
                       count(  DISTINCT customer_id ) as number_of_customer,
                       avg(revenue * units_sold)as avg_revenue_per_customer,
                       avg( customer_lifetime_value) as avg_customer_lifetime_value
from customer_transactions
group by customer_segment;
 





 