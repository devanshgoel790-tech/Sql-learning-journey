DROP DATABASE IF EXISTS loan_cte_db;
CREATE DATABASE loan_cte_db;
USE loan_cte_db;

CREATE TABLE customers (
  customer_id   INT PRIMARY KEY,
  customer_name VARCHAR(40),
  city          VARCHAR(20),
  segment       VARCHAR(20)
);

CREATE TABLE loans (
  loan_id       INT PRIMARY KEY,
  customer_id   INT,
  loan_type     VARCHAR(20),
  amount        DECIMAL(12,2),
  interest_rate DECIMAL(5,2),
  status        VARCHAR(20),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1,'Aarav Mehta','Meerut','Retail'),
(2,'Bhavna Rao','Delhi','Corporate'),
(3,'Chirag Jain','Mumbai','Retail'),
(4,'Divya Nair','Pune','SME'),
(5,'Eshan Verma','Delhi','SME'),
(6,'Farah Khan','Mumbai','Corporate'),
(7,'Gaurav Singh','Meerut','Retail'),
(8,'Hina Shah','Pune','Corporate'),
(9,'Imran Ali','Delhi','Retail'),
(10,'Jaya Iyer','Mumbai','SME');

INSERT INTO loans VALUES
(1,1,'Home',4500000,8.50,'Active'),
(2,1,'Personal',300000,12.00,'Closed'),
(3,2,'Business',8000000,10.00,'Active'),
(4,2,'Car',900000,9.00,'Overdue'),
(5,3,'Home',3500000,8.70,'Active'),
(6,3,'Personal',200000,13.50,'Overdue'),
(7,4,'Business',2500000,11.00,'Active'),
(8,4,'Personal',150000,14.00,'Closed'),
(9,5,'Business',1800000,11.50,'Overdue'),
(10,5,'Car',700000,9.50,'Active'),
(11,6,'Business',12000000,9.80,'Active'),
(12,6,'Home',6000000,8.40,'Active'),
(13,7,'Car',600000,9.20,'Closed'),
(14,7,'Personal',250000,13.00,'Active'),
(15,8,'Home',5200000,8.60,'Active'),
(16,8,'Business',9500000,10.20,'Overdue'),
(17,1,'Car',800000,9.10,'Active'),
(18,3,'Car',550000,9.30,'Closed'),
(19,6,'Personal',400000,12.50,'Active'),
(20,2,'Home',7000000,8.30,'Active');

select * from customers;
select * from loans;

WITH TOTAL_LOAN_AMOUNT_PER_CUSTOMER AS (
  SELECT  c.customer_id, c.customer_name,
	     sum(l.amount) as total_amount 
         from customers c
         INNER JOIN loans l
    ON c.customer_id = l.customer_id
     group by  c.customer_name ,c.customer_id)

select customer_name, total_amount
 from  TOTAL_LOAN_AMOUNT_PER_CUSTOMER
 ORDER BY  total_amount DESC;
 
 WITH CUSTOMERS_WITH_THREE_OR_MORE_LOAN AS(
    SELECT c.customer_name, 
	count(distinct l.loan_id) AS number_of_loans
    from customers c
    INNER JOIN loans l
    ON c.customer_id = l.customer_id 
    GROUP BY  c.customer_name)
select * from CUSTOMERS_WITH_THREE_OR_MORE_LOAN
where  number_of_loans >= 3;

WITH TOTAL_ACTIVE_LOAN_AMOUNT_PER_CUSTOMER AS(
    SELECT c.customer_name,
            l.status,
           c.city,
           sum(l.amount)as total_active_loan 
           from customers c
           INNER JOIN loans l
           ON c.customer_id = l.customer_id 
           Group BY  c.customer_name,c.city, l.status )
SELECT customer_name,
           city,
           total_active_loan 
           FROM TOTAL_ACTIVE_LOAN_AMOUNT_PER_CUSTOMER
WHERE status = 'Active'
ORDER BY total_active_loan DESC;

WITH AVG_INTEREST_RATE_PER_CUSTOMERS AS(
	SELECT c.customer_name,
           ROUND(AVG(l.interest_rate),2)AS avg_interest_rate
           from customers c
			INNER JOIN loans l 
            ON c.customer_id = l.customer_id 
            GROUP BY customer_name )
SELECT * FROM  AVG_INTEREST_RATE_PER_CUSTOMERS 
WHERE avg_interest_rate > 10
ORDER BY avg_interest_rate DESC ;

WITH TOTAL_LOAN_AMOUNT_PER_CITY AS(
 SELECT c.city,
		SUM(l.amount)as total_loan
        from customers c
        INNER JOIN loans l 
        ON c.customer_id = l.customer_id 
        GROUP BY c.city )
SELECT * FROM TOTAL_LOAN_AMOUNT_PER_CITY
WHERE total_loan > 18000000
ORDER BY total_loan DESC;

WITH TOTAL_LOAN_AMOUNT_PER_SEGMENT AS (
	 select c.segment,
            SUM(l.amount)as total_loan_amount
            from customers c
            INNER JOIN loans l 
			ON c.customer_id = l.customer_id 
            GROUP BY c.segment )
SELECT * FROM TOTAL_LOAN_AMOUNT_PER_SEGMENT
 ORDER BY total_loan_amount DESC;
 
 WITH NO_OF_OVERDUE_LOAN_PER_CUSTOMERS AS(
    SELECT c.customer_name, l.status,
          count( l.status)AS OVERDUE_COUNT
          from customers c
          INNER JOIN loans l 
          on c.customer_id = l.customer_id 
          GROUP BY c.customer_name, l.status)
SELECT  customer_name,
        OVERDUE_COUNT
        FROM NO_OF_OVERDUE_LOAN_PER_CUSTOMERS
WHERE status = 'Overdue' ;

WITH CUSTOMERS_WITH_NO_LOAN AS(
      SELECT c.customer_name,
            c.city ,
            l.loan_id 
            from customers c
            LEFT JOIN loans l
            ON c.customer_id = l.customer_id )
SELECT  customer_name,
		city 
FROM  CUSTOMERS_WITH_NO_LOAN
where loan_id IS NULL;

WITH customer_totals AS (
    SELECT customer_id, 
	SUM(amount) AS total_amount
    FROM loans
    GROUP BY customer_id)
SELECT c.customer_name, 
      t.total_amount
FROM customer_totals t
JOIN customers c 
ON t.customer_id = c.customer_id
WHERE t.total_amount > (SELECT AVG(total_amount) FROM customer_totals)
ORDER BY t.total_amount DESC;


WITH segment_summary AS (
    SELECT c.segment,
           COUNT(l.loan_id) AS number_of_loans,
           ROUND(AVG(l.interest_rate), 2) AS average_rate
    FROM customers c
    INNER JOIN loans l 
    ON c.customer_id = l.customer_id
    GROUP BY c.segment)
SELECT * FROM segment_summary
WHERE number_of_loans >= 5;
  

