CREATE DATABASE business_analytics;
USE business_analytics;

CREATE TABLE business_analytics (
  transaction_id INT PRIMARY KEY,
  department VARCHAR(30),
  region VARCHAR(20),
  employee_id INT,
  product_category VARCHAR(30),
  revenue DECIMAL(12,2),
  cost DECIMAL(10,2),
  units_sold INT,
  transaction_date DATE,
  customer_segment VARCHAR(20),
  discount_percent INT,
  profit_margin DECIMAL(8,2)
);

INSERT INTO business_analytics VALUES
(1001, 'Sales', 'North', 101, 'Electronics', 450000, 180000, 15, '2026-09-01', 'Premium', 5, 60),
(1002, 'Sales', 'South', 102, 'Software', 280000, 98000, 8, '2026-09-02', 'Standard', 10, 65),
(1003, 'IT', 'East', 103, 'Hardware', 320000, 145000, 12, '2026-09-01', 'Premium', 0, 55),
(1004, 'Finance', 'West', 104, 'Services', 165000, 75000, 5, '2026-09-03', 'Basic', 15, 55),
(1005, 'Sales', 'North', 101, 'Electronics', 520000, 195000, 18, '2026-09-02', 'Premium', 5, 62),
(1006, 'HR', 'South', 105, 'Software', 210000, 72000, 6, '2026-09-04', 'Standard', 20, 66),
(1007, 'IT', 'North', 103, 'Hardware', 380000, 172000, 14, '2026-09-03', 'Premium', 0, 55),
(1008, 'Finance', 'East', 106, 'Services', 195000, 88000, 6, '2026-09-05', 'Standard', 10, 55),
(1009, 'Sales', 'West', 102, 'Electronics', 620000, 248000, 22, '2026-09-04', 'Premium', 5, 60),
(1010, 'HR', 'North', 107, 'Software', 155000, 60000, 4, '2026-09-06', 'Basic', 25, 61),
(1011, 'IT', 'South', 108, 'Hardware', 410000, 185000, 16, '2026-09-05', 'Premium', 0, 55),
(1012, 'Finance', 'West', 109, 'Services', 225000, 102000, 7, '2026-09-07', 'Standard', 10, 55),
(1013, 'Sales', 'East', 110, 'Electronics', 385000, 154000, 13, '2026-09-06', 'Premium', 10, 60),
(1014, 'HR', 'South', 111, 'Software', 185000, 68000, 5, '2026-09-08', 'Standard', 20, 63),
(1015, 'IT', 'West', 112, 'Hardware', 475000, 214000, 18, '2026-09-07', 'Premium', 0, 55),
(1016, 'Finance', 'North', 113, 'Services', 285000, 128000, 9, '2026-09-09', 'Premium', 5, 55),
(1017, 'Sales', 'South', 114, 'Electronics', 540000, 216000, 19, '2026-09-08', 'Premium', 5, 60),
(1018, 'HR', 'East', 115, 'Software', 220000, 84000, 6, '2026-09-10', 'Standard', 15, 62),
(1019, 'IT', 'North', 116, 'Hardware', 355000, 160000, 13, '2026-09-09', 'Standard', 5, 55),
(1020, 'Finance', 'South', 117, 'Services', 310000, 140000, 10, '2026-09-11', 'Premium', 0, 55);

select * from business_analytics;

select department, region ,
                          sum(revenue)as total_revenue,
                          avg(profit_margin)as avg_profit_margin,
                          sum( units_sold)as total_unit,
                          count(transaction_id)as count_transaction
 from business_analytics
 group by department, region
 having  sum(revenue) > 800000
    and  avg(profit_margin) > 58
    and  sum( units_sold) > 30
    and count(transaction_id) >= 2
order by  sum(revenue) desc;
 
 select customer_segment, department,
                                    sum(revenue)as total_revenue,
                                    sum(cost)as total_cost,
                                    sum(revenue - cost) as total_profit,
									avg( units_sold)as avg_unit, 
                                    avg( discount_percent)as avg_discount,
									count(transaction_id)as count_transaction
from business_analytics
group by customer_segment, department
having   sum(revenue - cost) > 400000
  and    avg( discount_percent) <=10
  and   count(transaction_id) >=2
order by  sum(revenue - cost) desc;

select  product_category,
                        sum(revenue)as total_revenue,
						sum(cost)as total_cost,
                        (sum(revenue-cost)/sum(revenue)) * 100 as profit_percentage,
                        avg(DISTINCT units_sold)AS avg_unit_per_transactions,
                        count(case
                                   when  customer_segment = "Premiun" then 1 else 0 end) as premium_customer_count,
                        count( case
                                   when customer_segment = "Standard" then 1 else 0 end) as standard_customer_count
from business_analytics
group by product_category
having  sum(revenue) > 1000000
  and   profit_percentage > 55
  and premium_customer_count >= 2
order by total_revenue desc; 

select region,
             sum(revenue)as total_revenue,  
			 sum(cost)as total_cost,                   
		     avg(profit_margin)as avg_profit_margin,            
             sum( units_sold)as total_unit, 
		     avg( discount_percent)as avg_discount,
             count( employee_id ) as employee_count,
             count(transaction_id)as count_transaction
 from business_analytics
 group by region
 having total_revenue > 1200000
  and   avg_profit_margin >= 57
  and   employee_count >= 2
  and   count_transaction >= 4
order by total_revenue desc;

select department,
	  customer_segment,
                      sum(revenue)as total_revenue,  
					  sum(cost)as total_cost, 
                      sum(revenue - cost) as gross_profit,
                      sum((revenue - cost)/ revenue * 100) as profit_percentage,
                      sum(units_sold) as total_units_sold,
                      avg( discount_percent)as avg_discount,
					  count(case
                                   when profit_margin > 60 then 1 else 0 end) as high_margin_count,
					  count(case
                                   when profit_margin <= 55  then 1 else 0 end) as low_margin_count,             
                      count(transaction_id)as count_transaction
from business_analytics
 group by department, customer_segment
 having total_revenue > 700000
   and  profit_percentage > 56
   and  gross_profit > 300000
   and  count_transaction >= 2
   and  avg_discount < 12
order by gross_profit desc;
 
                      
                 
                 


                                    
		
					
                                    
                                    
                                    