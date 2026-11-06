CREATE Database loan_disbursals;
USE loan_disbursals;

CREATE TABLE loan_disbursals (
  loan_id       INT PRIMARY KEY,
  branch        VARCHAR(20),
  loan_type     VARCHAR(20),
  disburse_date DATE,
  amount        INT
);
INSERT INTO loan_disbursals VALUES
(1,  'Delhi',  'Personal', '2026-04-05',  300000),
(2,  'Delhi',  'Auto',     '2026-04-20',  450000),
(3,  'Delhi',  'Home',     '2026-05-10', 2500000),
(4,  'Delhi',  'Personal', '2026-06-02',  300000),
(5,  'Delhi',  'Business', '2026-06-25', 1200000),
(6,  'Delhi',  'Auto',     '2026-07-14',  450000),
(7,  'Mumbai', 'Home',     '2026-04-08', 3500000),
(8,  'Mumbai', 'Personal', '2026-04-28',  500000),
(9,  'Mumbai', 'Business', '2026-05-15', 1200000),
(10, 'Mumbai', 'Auto',     '2026-06-09',  600000),
(11, 'Mumbai', 'Personal', '2026-06-30',  500000),
(12, 'Mumbai', 'Home',     '2026-07-21', 2500000),
(13, 'Pune',   'Auto',     '2026-04-12',  400000),
(14, 'Pune',   'Personal', '2026-05-03',  250000),
(15, 'Pune',   'Home',     '2026-05-27', 1800000),
(16, 'Pune',   'Business', '2026-06-18',  900000),
(17, 'Pune',   'Auto',     '2026-07-08',  400000),
(18, 'Pune',   'Personal', '2026-07-29',  250000);

SELECT * FROM loan_disbursals;

SELECT loan_id,
	   branch, 
       amount,
       row_number()over(order by amount desc) as row_num
       from loan_disbursals;
       
SELECT loan_id,
	   branch,
       amount,
       sum(amount)
       OVER(ORDER BY amount) as total_amount
       from loan_disbursals;
	
SELECT loan_id,
	   branch,
       loan_type,
       amount,
	  RANK()OVER(PARTITION BY loan_type ORDER BY amount) as rank_high_loan_branches
      FROM loan_disbursals;
      
SELECT loan_id,
	   branch,
       amount,
       ROUND
		   (AVG(amount)OVER(PARTITION BY branch), 2 )as branch_avg_amount
           FROM  loan_disbursals;

SELECT loan_id,
	   branch,
       amount,
       DENSE_RANK()OVER(PARTITION BY branch ORDER BY amount desc) as rk
       FROM loan_disbursals; 
       
SELECT loan_id,
	   branch,
       amount,
	ROUND(amount -  avg(amount)OVER(PARTITION BY  branch), 2)as DIFF_changed
          FROM loan_disbursals; 
          
SELECT 
    loan_id, 
    branch, 
    disburse_date, 
    amount, 
    LAG(amount) OVER (PARTITION BY branch ORDER BY disburse_date) AS previous_disbursal_amount
FROM loan_disbursals; 

    
SELECT 
    loan_id, 
    branch, 
    disburse_date, 
    amount, 
    LEAD(amount) OVER (PARTITION BY branch ORDER BY disburse_date) AS next_disbursal_amount
FROM loan_disbursals; 
    
SELECT 
    loan_id, 
    branch, 
    disburse_date, 
    amount, 
    SUM(amount) OVER (PARTITION BY branch ORDER BY disburse_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )AS running_total
FROM loan_disbursals; 

SELECT 
    loan_id, 
    branch, 
    disburse_date, 
    amount, 
    (amount - FIRST_VALUE(amount)OVER(PARTITION BY branch ORDER BY  disburse_date))AS diff_btw_first_disbursal
    FROM loan_disbursals; 
