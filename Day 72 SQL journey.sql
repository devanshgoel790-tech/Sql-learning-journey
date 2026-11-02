DROP DATABASE  invest_rank_db;
CREATE DATABASE invest_rank_db;
USE invest_rank_db;

CREATE TABLE advisors (
  advisor_id INT PRIMARY KEY,
  advisor_name VARCHAR(50),
  city VARCHAR(30)
);

CREATE TABLE investments (
  inv_id INT PRIMARY KEY,
  advisor_id INT,
  product VARCHAR(30),
  amount INT,
  FOREIGN KEY (advisor_id) REFERENCES advisors(advisor_id)
);

INSERT INTO advisors VALUES
(1,'Aarav Mehta','Delhi'),
(2,'Neha Kapoor','Delhi'),
(3,'Rohit Sharma','Delhi'),
(4,'Priya Nair','Mumbai'),
(5,'Karan Shah','Mumbai'),
(6,'Sneha Iyer','Mumbai'),
(7,'Vikram Joshi','Pune'),
(8,'Anjali Rao','Pune');

INSERT INTO investments VALUES
(1,1,'Mutual Fund',500000),
(2,1,'Bonds',300000),
(3,1,'Equity',450000),
(4,2,'Mutual Fund',620000),
(5,2,'Equity',380000),
(6,2,'Bonds',300000),
(7,3,'Mutual Fund',250000),
(8,3,'Bonds',410000),
(9,3,'Equity',520000),
(10,4,'Mutual Fund',800000),
(11,4,'Equity',450000),
(12,4,'Bonds',350000),
(13,5,'Mutual Fund',620000),
(14,5,'Equity',300000),
(15,5,'Bonds',280000),
(16,6,'Mutual Fund',350000),
(17,6,'Equity',610000),
(18,6,'Bonds',450000),
(19,7,'Mutual Fund',400000),
(20,7,'Equity',270000),
(21,7,'Bonds',330000),
(22,8,'Mutual Fund',560000),
(23,8,'Equity',490000),
(24,8,'Bonds',390000);


SELECT inv_id, product, amount,
       RANK() OVER (ORDER BY amount DESC) AS amt_rank
FROM investments
ORDER BY amt_rank, inv_id;


WITH advisor_totals AS (
  SELECT advisor_id, SUM(amount) AS total
  FROM investments
  GROUP BY advisor_id
)
SELECT a.advisor_name, t.total,
       RANK() OVER (ORDER BY t.total DESC) AS rk
FROM advisor_totals t
JOIN advisors a ON a.advisor_id = t.advisor_id
ORDER BY rk;


SELECT product, inv_id, amount,
       DENSE_RANK() OVER (PARTITION BY product ORDER BY amount DESC) AS dr
FROM investments
ORDER BY product, dr, inv_id;


WITH ranked AS (
  SELECT inv_id, product, amount,
         ROW_NUMBER() OVER (
           PARTITION BY product
           ORDER BY amount DESC, inv_id
         ) AS rn
  FROM investments
)
SELECT inv_id, product, amount
FROM ranked
WHERE rn <= 2
ORDER BY product, rn;


WITH advisor_totals AS (
  SELECT advisor_id, SUM(amount) AS total
  FROM investments
  GROUP BY advisor_id
),
city_rank AS (
  SELECT a.advisor_name, a.city, t.total,
         RANK() OVER (PARTITION BY a.city ORDER BY t.total DESC) AS rk
  FROM advisor_totals t
  JOIN advisors a ON a.advisor_id = t.advisor_id
)
SELECT advisor_name, city, total
FROM city_rank
WHERE rk = 1
ORDER BY city;
