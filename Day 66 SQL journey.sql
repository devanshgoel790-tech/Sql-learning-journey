CREATE DATABASE sales_cte_db;
USE sales_cte_db;

CREATE TABLE sales (
  sale_id INT PRIMARY KEY,
  region VARCHAR(20),
  product VARCHAR(20),
  rep VARCHAR(20),
  amount INT
);

INSERT INTO sales VALUES
(1,'North','Laptop','Aarav',60000),
(2,'North','Phone','Aarav',25000),
(3,'North','Tablet','Diya',18000),
(4,'North','Phone','Diya',22000),
(5,'South','Laptop','Kabir',55000),
(6,'South','Printer','Kabir',9000),
(7,'South','Phone','Neha',24000),
(8,'South','Tablet','Neha',16000),
(9,'East','Laptop','Rohan',62000),
(10,'East','Phone','Rohan',21000),
(11,'East','Printer','Isha',8000),
(12,'East','Tablet','Isha',15000),
(13,'East','Phone','Arjun',23000),
(14,'West','Laptop','Meera',58000),
(15,'West','Phone','Meera',26000),
(16,'West','Printer','Sahil',7000),
(17,'West','Tablet','Sahil',17000),
(18,'West','Phone','Tanya',20000),
(19,'North','Printer','Aarav',8500),
(20,'South','Laptop','Neha',57000);

select * from sales;

WITH TOTAL_SALES AS (
 SELECT region ,
 SUM(amount)AS TOTAL_SALE
 from sales 
 GROUP BY region )
 SELECT * FROM TOTAL_SALES
 Order by TOTAL_SALE desc;
 
 WITH TOTAL_SALES AS (
 SELECT region ,
 SUM(amount)AS TOTAL_SALE
 from sales 
 GROUP BY region )
 SELECT * FROM TOTAL_SALES
 WHERE  TOTAL_SALE > 130000
 Order by TOTAL_SALE desc;
 
WITH HIGHEST_REGION AS (
 SELECT region ,
 SUM(amount)AS TOTAL_SALE
 from sales 
 GROUP BY region )
 SELECT * FROM  HIGHEST_REGION 
  Order by TOTAL_SALE desc
  LIMIT 1;

WITH PER_PRODUCT_SALE AS (
SELECT product,
      SUM(amount)AS TOTAL_SALE
      from sales 
      group by product )
select * from PER_PRODUCT_SALE
ORDER BY  TOTAL_SALE DESC ;

 WITH BIG_SALE_COUNT AS(
  SELECT region, 
	     amount as sales 
         from sales 
         WHERE amount >= 25000
       )
select region,count(*)from  BIG_SALE_COUNT
GROUP BY region
order by region;

WITH TOTAL_SALE_PER_REP AS (
 SELECT rep,
       sum(amount)as total_sale
       from sales
       group by rep )
select * from TOTAL_SALE_PER_REP
where total_sale > 50000
order by total_sale desc ;

WITH LAPTOP_SALES AS (
    SELECT region, amount 
    FROM sales
    WHERE product = 'Laptop'  
)
SELECT 
    region, 
    SUM(amount) AS total_laptop_sales  
FROM LAPTOP_SALES
GROUP BY region                       
ORDER BY total_laptop_sales DESC;     

WITH RegionTotals AS (
    SELECT region, 
        SUM(amount) AS total_sales
    FROM sales
    GROUP BY region
)
SELECT region, total_sales
FROM RegionTotals
WHERE total_sales > (SELECT AVG(total_sales) FROM RegionTotals);

select * from sales;