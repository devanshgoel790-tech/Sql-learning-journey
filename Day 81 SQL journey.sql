CREATE DATABASE IF NOT EXISTS client_db;
USE client_db;

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS clients;

CREATE TABLE clients (
  client_id     INT PRIMARY KEY,
  first_name    VARCHAR(30),
  last_name     VARCHAR(30),
  email         VARCHAR(50),
  phone         VARCHAR(20),
  city          VARCHAR(20),
  referral_code VARCHAR(10)
);

CREATE TABLE payments (
  payment_id INT PRIMARY KEY,
  client_id  INT,
  amount     INT,
  discount   INT,
  units      INT
);

INSERT INTO clients VALUES
(1,  'Aarav',  'Mehta', 'Aarav.Mehta@Mail.com',  '9876543210',  'Delhi',     'REF101'),
(2,  ' Riya',  'Das',   'riya.das@mail.com',     '98765-43211', 'mumbai',    NULL),
(3,  'Kabir ', 'Singh', 'KABIR.SINGH@MAIL.COM',  '9876543212',  NULL,        'REF103'),
(4,  'Maya',   'Shah',  'Maya.Shah@mail.com',    '98765-43213', 'Jaipur',    NULL),
(5,  ' Noah ', 'Patel', 'noah.patel@mail.com',   '98765432',    'Delhi',     'REF105'),
(6,  'Zoya',   'Khan',  'Zoya.Khan@Mail.com',    '9876543215',  'MUMBAI',    NULL),
(7,  'Isha',   'Rao',   'isha.rao@mail.com',     '98765-4321',  'Pune',      NULL),
(8,  'Arjun',  'Nair',  'Arjun.Nair@mail.com',   '9876543217',  NULL,        'REF108'),
(9,  'Neha',   'Gupta', 'neha.gupta@mail.com',   '98765-43218', 'Hyderabad', NULL),
(10, 'Sameer', 'Khan',  'Sameer.Khan@Mail.com',  '9876543219',  'Mumbai',    'REF110');

INSERT INTO payments VALUES
(1,  1,  12000, 500,  10),
(2,  1,   8000, NULL,  8),
(3,  2,  15000, 1000, 12),
(4,  3,   6000, NULL,  0),
(5,  4,   9500, NULL,  5),
(6,  4,   4200, 200,   4),
(7,  6,  18000, NULL, 15),
(8,  6,   7000, 350,   0),
(9,  7,   5200, NULL,  6),
(10, 9,  11000, 600,   9),
(11, 9,   3000, NULL,  3),
(12, 10, 22000, 2000, 20);

SELECT * FROM clients;
SELECT * FROM payments;

SELECT client_id,
       CONCAT(first_name, ' ', last_name) AS full_name
FROM clients;

SELECT client_id,
       UPPER(city)  AS city_upper,
       LOWER(email) AS email_lower
FROM clients;


SELECT client_id, first_name,
       TRIM(first_name) AS clean_first_name
FROM clients
WHERE first_name <> TRIM(first_name);


SELECT client_id,
       UPPER(SUBSTRING(last_name, 1, 3)) AS short_code
FROM clients;


SELECT client_id,
       REPLACE(phone, '-', '')         AS clean_phone,
       LENGTH(REPLACE(phone, '-', '')) AS phone_length
FROM clients
WHERE LENGTH(REPLACE(phone, '-', '')) <> 10;


SELECT client_id,
       COALESCE(city, 'Unknown') AS city
FROM clients;

SELECT payment_id,
       amount - COALESCE(discount, 0) AS net_amount
FROM payments;


SELECT CONCAT(TRIM(c.first_name), ' ', c.last_name) AS full_name,
       SUM(p.amount - COALESCE(p.discount, 0))      AS total_net
FROM clients c
INNER JOIN payments p ON c.client_id = p.client_id
GROUP BY c.client_id, c.first_name, c.last_name
ORDER BY total_net DESC;

SELECT payment_id, amount, units,
       ROUND(amount / NULLIF(units, 0), 2) AS amount_per_unit
FROM payments;


SELECT CONCAT(TRIM(c.first_name), ' ', c.last_name) AS full_name,
       COALESCE(SUM(p.amount - COALESCE(p.discount, 0)), 0) AS total_net
FROM clients c
LEFT JOIN payments p ON c.client_id = p.client_id
GROUP BY c.client_id, c.first_name, c.last_name
ORDER BY total_net DESC, full_name;

