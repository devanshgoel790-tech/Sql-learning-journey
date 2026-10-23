CREATE DATABASE invoice_db;
USE invoice_db;

CREATE TABLE vendors (
  vendor_id INT PRIMARY KEY,
  vendor_name VARCHAR(30),
  city VARCHAR(20)
);
CREATE TABLE invoices (
  invoice_id INT PRIMARY KEY,
  vendor_id INT,
  category VARCHAR(20),
  amount INT
);
CREATE TABLE payments (
  payment_id INT PRIMARY KEY,
  invoice_id INT,
  paid_amount INT
);

INSERT INTO vendors VALUES
(1,'Sharma Traders','Meerut'),
(2,'Gupta Steel','Delhi'),
(3,'Mehta Logistics','Mumbai'),
(4,'Rao Packaging','Chennai'),
(5,'Khan Textiles','Kanpur'),
(6,'Iyer Software','Bengaluru'),
(7,'Verma Foods','Meerut'),
(8,'Joshi Paper','Pune');

INSERT INTO invoices VALUES
(101,1,'Raw Material',50000),
(102,1,'Freight',12000),
(103,2,'Raw Material',90000),
(104,3,'Freight',30000),
(105,3,'Freight',45000),
(106,4,'Packaging',20000),
(107,5,'Raw Material',70000),
(108,6,'Software',60000),
(109,6,'Software',25000),
(110,2,'Freight',15000),
(111,7,'Packaging',18000);

INSERT INTO payments VALUES
(1,101,50000),
(2,103,90000),
(3,104,30000),
(4,106,20000),
(5,108,60000),
(6,102,12000),
(7,107,70000),
(8,110,15000);

select * from invoices;
select* from payments;
select * from vendors;

select invoice_id, category, amount
from invoices 
order by amount desc
LIMIT 1;

select DISTINCT v.vendor_name
from vendors v
Left join invoices i
ON v.vendor_id = i.vendor_id
where i.category = 'Freight'
order by v.vendor_name;

select v.vendor_name, v.city
from vendors v
LEFT JOIN invoices i 
ON v.vendor_id = i.vendor_id 
where i.invoice_id IS NULL;

select v.vendor_name, i.amount
from invoices i
INNER JOIN vendors v
ON i.vendor_id = v.vendor_id 
where i.amount> (select avg(amount) from invoices )
order by i.amount desc;

SELECT v.vendor_name, i.invoice_id, i.amount
FROM invoices i
INNER JOIN vendors v ON i.vendor_id = v.vendor_id
LEFT JOIN payments p 
on i.invoice_id = p.invoice_id 
WHERE p.invoice_id  IS NULL
ORDER BY i.amount DESC;




