DROP DATABASE IF EXISTS card_cte_db;
CREATE DATABASE card_cte_db;
USE card_cte_db;

CREATE TABLE cardholders (
  holder_id   INT PRIMARY KEY,
  holder_name VARCHAR(40),
  city        VARCHAR(20),
  card_type   VARCHAR(20)
);

CREATE TABLE card_spends (
  spend_id    INT PRIMARY KEY,
  holder_id   INT,
  category    VARCHAR(20),
  amount      DECIMAL(10,2),
  spend_month VARCHAR(7),
  FOREIGN KEY (holder_id) REFERENCES cardholders(holder_id)
);

INSERT INTO cardholders VALUES
(1,'Arjun Kulkarni','Pune','Gold'),
(2,'Bela Menon','Kochi','Platinum'),
(3,'Chetan Yadav','Lucknow','Silver'),
(4,'Disha Tripathi','Pune','Gold'),
(5,'Eklavya Roy','Kolkata','Platinum'),
(6,'Gita Rajan','Kochi','Silver'),
(7,'Harsh Vora','Surat','Gold'),
(8,'Ira Bhatt','Lucknow','Silver');

INSERT INTO card_spends VALUES
(1,1,'Travel',18500,'2026-07'),
(2,1,'Dining',3200,'2026-07'),
(3,1,'Shopping',7600,'2026-08'),
(4,2,'Travel',42000,'2026-07'),
(5,2,'Shopping',15800,'2026-08'),
(6,2,'Dining',5400,'2026-09'),
(7,2,'Travel',28500,'2026-09'),
(8,3,'Fuel',4100,'2026-07'),
(9,3,'Bills',2600,'2026-08'),
(10,4,'Dining',6100,'2026-07'),
(11,4,'Travel',9800,'2026-08'),
(12,4,'Shopping',12300,'2026-09'),
(13,5,'Travel',36500,'2026-08'),
(14,5,'Shopping',21400,'2026-08'),
(15,5,'Dining',7900,'2026-09'),
(16,6,'Bills',3300,'2026-07'),
(17,6,'Fuel',5200,'2026-09'),
(18,6,'Dining',2800,'2026-09'),
(19,7,'Shopping',9100,'2026-07'),
(20,7,'Travel',15200,'2026-09'),
(21,1,'Fuel',4800,'2026-09'),
(22,5,'Bills',6200,'2026-07');

select * from card_spends;
select * from cardholders;

WITH TOTAL_SPEND_PER_CARDHOLDER AS (
     SELECT c.holder_name, 
     SUM(cs.amount)AS total_spend
     from cardholders c
     INNER JOIN card_spends cs
     ON c.holder_id = cs.holder_id 
     GROUP BY  c.holder_name )
SELECT * FROM TOTAL_SPEND_PER_CARDHOLDER 
order by  total_spend desc;

WITH TOTAL_SPEND_PER_CITY AS (
  SELECT c.city,
   SUM(cs.amount)AS total_spend   
   FROM cardholders c
     INNER JOIN card_spends cs
     ON c.holder_id = cs.holder_id 
     GROUP BY c.city )
select * from TOTAL_SPEND_PER_CITY
WHERE total_spend > 50000
ORDER BY total_spend DESC ;

WITH CARDHOLDERS_WITH_EQUAL_OR_MORE_SPEND AS(
   SELECT c.holder_name,
	COUNT(cs.spend_id) as number_of_spend
	  FROM cardholders c
     INNER JOIN card_spends cs
     ON c.holder_id = cs.holder_id 
     GROUP BY c.holder_name )
SELECT * FROM CARDHOLDERS_WITH_EQUAL_OR_MORE_SPEND
WHERE number_of_spend >= 4 ;

WITH AVERAGE_TRAVEL_SPEND_PER_CARDHOLDER AS(
    SELECT c.holder_name, 
           c.city,
           ROUND(AVG(cs.amount), 2)as avg_spend
	FROM cardholders c
     INNER JOIN card_spends cs
     ON c.holder_id = cs.holder_id 
     WHERE cs.category = 'Travel'
     GROUP BY c.holder_name, c.city )
SELECT * FROM  AVERAGE_TRAVEL_SPEND_PER_CARDHOLDER
ORDER BY avg_spend DESC;

WITH CARDHOLDERS_SPEND_ABOVE_AVERAGE_CARDHOLDER_TOTAL AS(
    SELECT c.holder_name,
		SUM(cs.amount)AS total_spend   
   FROM cardholders c
   INNER JOIN card_spends cs
   ON c.holder_id = cs.holder_id 
   GROUP BY c.holder_name )
select * from CARDHOLDERS_SPEND_ABOVE_AVERAGE_CARDHOLDER_TOTAL
   where  total_spend > ( select avg(total_spend) from CARDHOLDERS_SPEND_ABOVE_AVERAGE_CARDHOLDER_TOTAL)
   ORDER BY total_spend DESC;

