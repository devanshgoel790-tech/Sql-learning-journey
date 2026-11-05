CREATE DATABASE branch_txn_db;
USE branch_txn_db;

CREATE TABLE branch_txns (
  txn_id INT PRIMARY KEY,
  txn_date DATE,
  branch VARCHAR(20),
  amount INT
);

INSERT INTO branch_txns VALUES
(1,'2026-10-01','Delhi',12000),
(2,'2026-10-01','Mumbai',18000),
(3,'2026-10-02','Pune',9000),
(4,'2026-10-03','Delhi',15000),
(5,'2026-10-03','Mumbai',11000),
(6,'2026-10-04','Pune',14000),
(7,'2026-10-05','Delhi',8000),
(8,'2026-10-06','Mumbai',20000),
(9,'2026-10-06','Pune',7000),
(10,'2026-10-07','Delhi',13000),
(11,'2026-10-08','Mumbai',16000),
(12,'2026-10-08','Pune',12000),
(13,'2026-10-09','Delhi',10000),
(14,'2026-10-10','Mumbai',9000),
(15,'2026-10-10','Pune',11000);

SELECT * FROM branch_txns;

SELECT txn_id,
	   branch, 
       amount, 
       SUM(amount)OVER(PARTITION BY branch ORDER BY amount) total_amount
       FROM branch_txns;
       
SELECT txn_id,
	   branch, 
       amount, 
       SUM(amount)OVER(PARTITION BY branch)as branch_total_amount
       FROM branch_txns;

SELECT txn_id,
	   branch, 
       amount, 
       AVG(amount)OVER(PARTITION BY branch)as branch_AVG_amount
	   FROM branch_txns;

SELECT
	   branch, 
       amount, 
       COUNT(txn_id)OVER(PARTITION BY branch)as number_of_tranctions
	   FROM branch_txns;
       
SELECT txn_id,
	   branch, 
       amount, 
       MAX(amount)OVER(PARTITION BY branch )as branch_MAX_amount,
	   MIN(amount)OVER(PARTITION BY branch)as branch_MIN_amount
	   FROM branch_txns;

SELECT txn_id,
	   branch, 
       amount, 
       amount - AVG(amount)OVER(PARTITION BY branch)as diff_from_branch_avg
       FROM branch_txns;
	
SELECT txn_date
	   branch, 
       amount, 
       SUM(amount)OVER(PARTITION BY branch ORDER BY txn_date)as branch_running_total
	   FROM branch_txns;

SELECT txn_date
	   branch, 
       amount, 
       SUM(amount)OVER( ORDER BY txn_date)as branch_running_total
	   FROM branch_txns;
