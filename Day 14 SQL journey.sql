CREATE database if not exists retail_store;
use retail_store;

CREATE TABLE store_transactions (
    transaction_id INT,
    store_location VARCHAR(50),
    product_category VARCHAR(50),
    amount DECIMAL(10, 2),
    payment_type VARCHAR(30),
    customer_type VARCHAR(30)
);

INSERT INTO store_transactions 
(transaction_id, store_location, product_category, amount, payment_type, customer_type) 
VALUES
(1, 'Downtown', 'Electronics', 1200.00, 'Credit Card', 'Member'),
(2, 'Suburbs', 'Clothing', 85.00, 'Cash', 'Regular'),
(3, 'Downtown', 'Groceries', 45.00, 'Debit Card', 'Regular'),
(4, 'Uptown', 'Electronics', 650.00, 'Credit Card', 'Member'),
(5, 'Suburbs', 'Groceries', 120.00, 'Cash', 'Member'),
(6, 'Uptown', 'Clothing', 210.00, 'Credit Card', 'Regular'),
(7, 'Downtown', 'Electronics', 300.00, 'Debit Card', 'Member'),
(8, 'Suburbs', 'Groceries', 95.00, 'Credit Card', 'Regular'),
(9, 'Uptown', 'Groceries', 150.00, 'Debit Card', 'Member'),
(10, 'Downtown', 'Clothing', 180.00, 'Cash', 'Member'),
(11, 'Suburbs', 'Electronics', 900.00, 'Credit Card', 'Regular'),
(12, 'Uptown', 'Clothing', 40.00, 'Cash', 'Regular');

SELECT store_location,SUM(AMOUNT) FROM STORE_TRANSACTIONS
group by store_location;

 SELECT PRODUCT_CATEGORY, count(*) from store_transactions
 GROUP BY product_category;
 
 select payment_type, sum(amount) from store_transactions
 group by payment_type;
 
 select store_location as location, payment_type as payment, sum(amount) from store_transactions
 where payment_type = "credit card"
 group by store_location ;
 
 select customer_type as loyal,avg(amount) from store_transactions
 where customer_type = "member"
 group by product_category;
 
SELECT store_location, COUNT(*) AS high_value_count
FROM store_transactions
WHERE amount > 100
GROUP BY store_location;

select payment_type,product_category, sum(amount) from store_transactions
where payment_type = "cash"
group by product_category;

select store_location, product_category, sum(amount) as total_sales from store_transactions
group by store_location , product_category
order by total_sales desc
limit 9;
 
 select store_location,sum(amount) from store_transactions
 where customer_type ="member"
 group by store_location, payment_type;
 
 
