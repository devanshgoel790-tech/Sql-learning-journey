CREATE DATABASE product_sales;
USE product_sales;

CREATE TABLE product_sales (
  sale_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  category VARCHAR(30),
  region VARCHAR(20),
  sale_amount DECIMAL(10,2),
  quantity_sold INT,
  discount_percent INT,
  customer_type VARCHAR(20),
  sales_date DATE,
  salesperson_id INT
);

INSERT INTO product_sales VALUES
(2001, 'Laptop Pro', 'Electronics', 'North', 95000, 2, 5, 'Corporate', '2026-09-01', 101),
(2002, 'Office Chair', 'Furniture', 'South', 15000, 5, 10, 'Retail', '2026-09-02', 102),
(2003, 'Monitor 4K', 'Electronics', 'East', 42000, 3, 0, 'Corporate', '2026-09-01', 103),
(2004, 'Desk', 'Furniture', 'North', 28000, 4, 15, 'Retail', '2026-09-03', 101),
(2005, 'Keyboard', 'Electronics', 'West', 8000, 10, 20, 'Retail', '2026-09-02', 104),
(2006, 'Mouse', 'Electronics', 'South', 4500, 15, 25, 'Retail', '2026-09-04', 102),
(2007, 'Filing Cabinet', 'Furniture', 'East', 22000, 3, 10, 'Corporate', '2026-09-03', 105),
(2008, 'Printer', 'Electronics', 'North', 55000, 2, 5, 'Corporate', '2026-09-05', 101),
(2009, 'Standing Desk', 'Furniture', 'West', 35000, 2, 0, 'Corporate', '2026-09-04', 104),
(2010, 'Monitor', 'Electronics', 'South', 32000, 4, 10, 'Retail', '2026-09-06', 103),
(2011, 'Bookshelf', 'Furniture', 'North', 12000, 5, 15, 'Retail', '2026-09-05', 105),
(2012, 'Laptop Basic', 'Electronics', 'East', 65000, 3, 5, 'Corporate', '2026-09-06', 103),
(2013, 'Headphones', 'Electronics', 'West', 6000, 8, 30, 'Retail', '2026-09-07', 102),
(2014, 'Whiteboard', 'Furniture', 'South', 8000, 4, 20, 'Retail', '2026-09-07', 104),
(2015, 'Webcam', 'Electronics', 'North', 5500, 12, 25, 'Retail', '2026-09-08', 101);

select * from product_sales;

select category, 
               sum(sale_amount)as total_sales_amount, 
               avg( quantity_sold)as avg_quantity_sold, 
               count(distinct sale_id )as nunber_of_transactions 
from product_sales
GROUP BY CATEGORY
HAVING  sum(sale_amount) > 100000
   and  avg( quantity_sold) > 2
   and  count(distinct sale_id) >=3
order by sum(sale_amount) desc;

select region ,customer_type, 
                           sum(sale_amount)as total_sales_amount, 
                           sum( discount_percent)as total_discount_percentage 
from product_sales
group by region , customer_type
having  sum( discount_percent) > 50
order by sum( discount_percent) desc;

select region, 
             avg(sale_amount) as avg_sale_amount ,
			avg(quantity_amount) as avg_quantity_sold, 
			 avg( discount_percent)as avg_discount_percentage  
from product_sales
group by region
having avg(sale_amount) > 35000
   and avg(sale_amount) > 12
   and avg( discount_percent) < 12
order by avg(sale_amount) desc;

select salesperson_id, 
                     sum(quantity_sold * sale_amount)as total_rvenue,
					 sum(quantity_sold) as total_quantity_sold,
                     avg(sale_amount) as avg_sale_amount,
					avg( discount_percent)as avg_discount_given,
					 count(distinct sale_id )as nunber_of_transactions 
from product_sales
group by salesperson_id
having   sum(quantity_sold * sale_amount) > 100000
    and  avg(sale_amount) > 20000
order by  sum(quantity_sold * sale_amount) desc;

select product_name, category, region, 
					          avg(sale_amount) as avg_sale_amount,
                              sum(quantity_sold * sale_amount) as total_revenue,   
							  avg( discount_percent)as avg_discount_given,
							  count(distinct sale_id )as nunber_of_transactions 
from product_sales
group by product_name,category, region
having   avg(sale_amount) > 25000
    and  sum(quantity_sold * sale_amount) > 5
    and avg( discount_percent) between 5 and 15
order by   avg(sale_amount) desc;

select customer_type, 
                     sum(sale_amount) as total_sales, 
                     avg(sale_amount) as avg_transaction_value,
                     count( product_name)as count_product,
					 avg( discount_percent)as avg_discount_given
from product_sales
group by customer_type
having sum(sale_amount) > 150000
   and avg(sale_amount) > 30000
   and count(product_name) > 5
   and avg( discount_percent) < 10
order by sum(sale_amount) desc;

select salesperson_id,
                     sum(quantity_sold * sale_amount)as total_revenue,
                     avg(sale_amount) as avg_transaction_value,  
                     sum(sale_amount) as total_quantity,   
					 avg( discount_percent)as avg_discount,
					count(distinct sale_id)as nunber_of_transactions,
                    avg(sale_amount) as avg_sales_per_transaction
from product_sales
group by salesperson_id
having  sum(quantity_sold * sale_amount) > 80000
   and  avg( discount_percent) > 10
   and 	count(distinct sale_id) >= 2
order by sum(quantity_sold * sale_amount) desc;

select category, region, customer_type,
									sum(quantity_sold * sale_amount)as total_sales,
									sum(quantity_sold) as total_quantity, 
								    avg( discount_percent)as avg_discount,
                                   count( sale_id)as nunber_of_transactions,  
									avg(sale_amount) as avg_sale_amount
from product_sales
group by category, region, customer_type
having  sum(quantity_sold * sale_amount) > 40000
  and  sum(sale_amount) > 3
  and  count(distinct sale_id) >= 2
  and  avg( discount_percent) < 15
order by sum(quantity_sold * sale_amount) desc;

SELECT 
    salesperson_id,
    SUM(quantity_sold * sale_amount) AS total_revenue,
    avg(sale_amount) AS avg_per_transaction,
    SUM(quantity_sold * sale_amount * (discount_percent / 100.0)) AS total_discount_amount,
    (AVG(discount_percent) / AVG(sale_amount)) AS discount_efficiency,
    SUM(quantity_sold) AS total_quantity,
    COUNT(sale_id) AS transaction_count
FROM product_sales
GROUP BY salesperson_id
HAVING 
    SUM(quantity_sold * sale_amount) > 70000
    AND AVG(sale_amount) > 15000
    AND SUM(quantity_sold) > 8
    AND AVG(discount_percent) <= 12
    AND COUNT(sale_id) >= 3
ORDER BY total_revenue DESC;              




