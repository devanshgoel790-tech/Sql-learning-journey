CREATE DATABASE customer_analytics;
USE customer_analytics;

CREATE TABLE customer_analytics (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  segment VARCHAR(30),
  acquisition_month VARCHAR(20),
  total_purchases DECIMAL(10,2),
  purchase_frequency INT,
  average_order_value DECIMAL(9,2),
  region VARCHAR(20),
  product_category VARCHAR(30),
  retention_months INT,
  churn_status VARCHAR(20),
  marketing_channel VARCHAR(30),
  customer_lifetime_value DECIMAL(12,2)
);

INSERT INTO customer_analytics VALUES
(5001, 'Rajesh Sharma', 'Premium', 'Jan-2026', 450000, 12, 37500, 'North', 'Electronics', 8, 'Active', 'Email', 950000),
(5002, 'Priya Desai', 'Standard', 'Feb-2026', 220000, 8, 27500, 'South', 'Software', 7, 'Active', 'Social', 520000),
(5003, 'Amit Kumar', 'Basic', 'Mar-2026', 85000, 4, 21250, 'East', 'Hardware', 6, 'Churned', 'Direct', 180000),
(5004, 'Neha Singh', 'Premium', 'Jan-2026', 520000, 14, 37143, 'North', 'Electronics', 9, 'Active', 'Email', 1100000),
(5005, 'Vikram Patel', 'Standard', 'Feb-2026', 280000, 10, 28000, 'West', 'Software', 7, 'Active', 'Social', 650000),
(5006, 'Deepak Roy', 'Premium', 'Apr-2026', 380000, 11, 34545, 'South', 'Electronics', 5, 'Active', 'Email', 850000),
(5007, 'Anjali Verma', 'Basic', 'May-2026', 95000, 5, 19000, 'East', 'Hardware', 4, 'Active', 'Direct', 220000),
(5008, 'Sanjay Gupta', 'Standard', 'Mar-2026', 310000, 9, 34444, 'North', 'Software', 6, 'Churned', 'Email', 720000),
(5009, 'Kavya Nair', 'Premium', 'Feb-2026', 480000, 13, 36923, 'West', 'Electronics', 8, 'Active', 'Social', 1000000),
(5010, 'Rohit Jain', 'Basic', 'Apr-2026', 110000, 6, 18333, 'South', 'Hardware', 5, 'Active', 'Direct', 280000),
(5011, 'Sneha Iyer', 'Standard', 'Jan-2026', 350000, 11, 31818, 'East', 'Software', 8, 'Active', 'Email', 800000),
(5012, 'Arjun Reddy', 'Premium', 'May-2026', 420000, 12, 35000, 'North', 'Electronics', 4, 'Active', 'Social', 900000),
(5013, 'Divya Malhotra', 'Basic', 'Jun-2026', 78000, 3, 26000, 'West', 'Hardware', 3, 'Churned', 'Direct', 140000),
(5014, 'Varun Singh', 'Standard', 'Mar-2026', 290000, 9, 32222, 'South', 'Software', 6, 'Active', 'Email', 680000),
(5015, 'Pooja Agarwal', 'Premium', 'Jan-2026', 550000, 15, 36667, 'East', 'Electronics', 9, 'Active', 'Social', 1150000);


select * from customer_analytics;

select segment, 
              sum(customer_id )as total_customer,
              avg(customer_lifetime_value)as avg_customer_lifetime_value, 
              sum( customer_lifetime_value)as total_lifetime_value, 
              avg( purchase_frequency)as avg_purchase_frequency,
              avg(average_order_value)as avg_order_value ,
              count(distinct customer_id )as count_customer
from customer_analytics
group by segment
order by total_lifetime_value desc;

select region, 
              avg(customer_lifetime_value)as avg_customer_lifetime_value, 
              count(distinct customer_id )as count_customer,
              sum( total_purchases)as total_purchases,
			  avg( purchase_frequency)as avg_purchase_frequency
from customer_analytics
group by region
order by  avg(customer_lifetime_value) desc;

select segment,
               count(customer_id )as total_customers,
		       count(case 
                         when  churn_status = 'active' Then 1 end)as active_customer,
               count(case 
                         when  churn_status = 'churned' then 1 end)as churn_customer,
               avg( retention_months)as avg_retention_months,
               avg(case
					   when churn_status = 'active' Then  customer_lifetime_value end) as avg_clv_active,
			  avg(case
			          when churn_status = 'churned' Then customer_lifetime_value end) as avg_clv_churned
from  customer_analytics
group by segment
order by total_customers desc;


select marketing_channel,
					count(customer_id )as count_customers,
					sum(customer_lifetime_value)as total_customer_lifetime_value ,  
				   avg(customer_lifetime_value)as avg_per_customer_lifetime_value,   
                   avg( purchase_frequency)as avg_purchase_frequency,
                   avg(average_order_value)as avg_order_value,
                    count(case 
                         when  churn_status = 'churned' then 1 else 0 end)as churn_count,
                   count(marketing_channel)as count_marketing_channel
from customer_analytics
group  by marketing_channel
having sum(customer_lifetime_value) > 2000000
order by sum(customer_lifetime_value) desc;

select acquisition_month ,
					    count(customer_id )as count_customers,  
					    sum(customer_lifetime_value)as total_customer_lifetime_value , 
						avg(customer_lifetime_value)as avg_per_customer_lifetime_value,  
                       avg( purchase_frequency)as avg_purchase_frequency, 
                       count(case
                                 when churn_status = 'active' then 1 else 0 end) as active_count,
						COUNT(CASE
                                 WHEN churn_status = 'Churned' THEN 1 END) * 1.0 / COUNT(customer_id) AS churn_rate
from customer_analytics
group by acquisition_month 
order by sum(customer_lifetime_value) desc;
                                 

                   
                           
               
               
               
			  
