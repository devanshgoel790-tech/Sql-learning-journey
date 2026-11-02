CREATE DATABASE mini_rank_db;
USE mini_rank_db;

CREATE TABLE mini_inv (
  investor VARCHAR(30),
  company  VARCHAR(30),
  amount   INT
);

INSERT INTO mini_inv VALUES
('Rahul','Google',500000),
('Rahul','Intel',300000),
('Rahul','Apple',450000),
('Sita','Google',400000),
('Sita','Intel',350000),
('Amit','Apple',600000),
('Amit','Google',200000),
('Amit','Intel',250000);

SELECT * FROM mini_inv;

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