CREATE DATABASE monthly_collection_db;
USE monthly_collection_db;

CREATE TABLE monthly_collections (
  id INT PRIMARY KEY,
  branch VARCHAR(20),
  month_start DATE,
  amount INT
);

INSERT INTO monthly_collections VALUES
(1,'Delhi','2026-04-01',420000),
(2,'Delhi','2026-05-01',450000),
(3,'Delhi','2026-06-01',430000),
(4,'Delhi','2026-07-01',480000),
(5,'Delhi','2026-08-01',520000),
(6,'Delhi','2026-09-01',500000),
(7,'Mumbai','2026-04-01',610000),
(8,'Mumbai','2026-05-01',590000),
(9,'Mumbai','2026-06-01',640000),
(10,'Mumbai','2026-07-01',700000),
(11,'Mumbai','2026-08-01',680000),
(12,'Mumbai','2026-09-01',720000),
(13,'Pune','2026-04-01',300000),
(14,'Pune','2026-05-01',320000),
(15,'Pune','2026-06-01',350000),
(16,'Pune','2026-07-01',340000),
(17,'Pune','2026-08-01',360000),
(18,'Pune','2026-09-01',390000);

SELECT * FROM monthly_collections;

SELECT branch, 
       month_start,
       amount,
       LAG(month_start)OVER(PARTITION BY branch ORDER BY month_start)as previous_month
       from  monthly_collections;

SELECT branch, 
       month_start,
       amount,
       LEAD(month_start)OVER(PARTITION BY branch ORDER BY month_start)as forward_month
       from  monthly_collections;
	
SELECT branch, 
       month_start,
       amount,
       amount -  LAG(amount)OVER(PARTITION BY  branch ORDER BY month_start)as DIFF_changed
       FROM monthly_collections;
       
SELECT branch, 
       month_start,
       amount,
       LEAD(amount)OVER(PARTITION BY branch ORDER BY month_start)- amount as amount_will_change
       from  monthly_collections;

SELECT branch, 
       month_start,
       amount,
       ROUND( 
            (( amount-LAG(amount)OVER(PARTITION BY branch ORDER BY month_start))
            / LAG(amount)OVER(PARTITION BY branch ORDER BY month_start))* 100,
            2) AS percentage_growth
            FROM  monthly_collections;
            
SELECT branch, 
       month_start,
       amount,
       FIRST_VALUE(amount)OVER(partition BY branch order by month_start ) as FIRST_MONTH_AMOUNT
       FROM  monthly_collections;
       
SELECT branch, 
       month_start,
       amount,
       amount - FIRST_VALUE(amount)OVER(partition BY branch order by month_start ) as GROWTH_SINCE_FIRST_MONTH_AMOUNT
       FROM  monthly_collections;
       
	