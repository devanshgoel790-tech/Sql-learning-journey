CREATE DATABASE JoinPractice;
USE JoinPractice;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers VALUES
(1,'Rahul Sharma','Delhi'),
(2,'Priya Verma','Mumbai'),
(3,'Aman Gupta','Bangalore'),
(4,'Sneha Patel','Ahmedabad'),
(5,'Rohit Mehta','Pune'),
(6,'Anjali Singh','Jaipur'),
(7,'Karan Malhotra','Chandigarh'),
(8,'Neha Kapoor','Hyderabad'),
(9,'Arjun Rao','Chennai'),
(10,'Meera Joshi','Lucknow'),
(11,'Vikas Yadav','Noida'),
(12,'Riya Shah','Surat');

INSERT INTO Products VALUES
(101,'Laptop','Electronics',65000),
(102,'Smartphone','Electronics',35000),
(103,'Headphones','Accessories',2500),
(104,'Office Chair','Furniture',8500),
(105,'Desk','Furniture',12000),
(106,'T-Shirt','Clothing',1200),
(107,'Jeans','Clothing',2500),
(108,'Smart Watch','Accessories',7500),
(109,'Microwave','Appliances',14000),
(110,'Air Conditioner','Appliances',42000);

INSERT INTO Orders VALUES
(1001,1,101,'2026-09-01',1,65000,'Completed'),
(1002,2,102,'2026-09-02',1,35000,'Completed'),
(1003,3,104,'2026-09-03',2,17000,'Completed'),
(1004,1,105,'2026-09-04',1,12000,'Pending'),
(1005,4,106,'2026-09-05',3,3600,'Completed'),
(1006,5,110,'2026-09-06',1,42000,'Cancelled'),
(1007,6,109,'2026-09-07',1,14000,'Completed'),
(1008,7,101,'2026-09-08',1,65000,'Completed'),
(1009,8,102,'2026-09-09',2,70000,'Pending'),
(1010,9,108,'2026-09-10',2,15000,'Completed'),
(1011,10,104,'2026-09-11',1,8500,'Completed'),
(1012,3,106,'2026-09-12',5,6000,'Completed'),
(1013,2,110,'2026-09-13',1,42000,'Completed'),
(1014,5,103,'2026-09-14',2,5000,'Pending'),
(1015,4,107,'2026-09-15',2,5000,'Completed'),
(1016,7,108,'2026-09-16',1,7500,'Completed'),
(1017,8,101,'2026-09-17',1,65000,'Completed'),
(1018,9,103,'2026-09-18',1,2500,'Cancelled');


select c.customer_name, o.order_id 
from customers c 
INNER JOIN orders o
on c.customer_id = o.customer_id ;

select o.order_id , p.product_name, o.quantity, o.total_amount
 from orders o 
 INNER JOIN products p 
 ON o.product_id = p.product_id ;
 
 select c.customer_name, p.product_name, o.total_amount
 from customers c
 INNER JOIN orders o 
 on c.customer_id = o.customer_id 
 INNER JOIN products p 
 ON o.product_id = p.product_id;
 
 select c.customer_name, p.product_name, o.total_amount
 from customers c
 INNER JOIN orders o 
  on c.customer_id = o.customer_id 
 INNER JOIN products p 
 ON o.product_id = p.product_id
 where order_status = 'completed';
 
 select o.order_id, c.customer_name, p.product_name, p.category, p.price 
from customers c
INNER JOIN ORDERS o 
on c.customer_id = o.customer_id 
INNER JOIN PRODUCTS p 
on o.product_id = p.product_id 
where category = 'Electronics' ;

select c.customer_name, p.product_name, o.total_amount
from customers c
INNER JOIN orders o 
on c.customer_id = o.customer_id 
INNER JOIN PRODUCTS p 
on o.product_id = p.product_id 
order by total_amount desc
limit 5;

select count(o.ORDER_ID)as order_count, c.city 
from orders o 
INNER  JOIN CUSTOMERS c 
on o.customer_id = c.customer_id 
group by city
order by  order_count desc;

select count(o.quantity)as total_quantity, p.product_name
from orders o 
INNER JOIN PRODUCTS p 
ON o.product_id = p.product_id
group by product_name 
order by  total_quantity desc
limit 5;

select c.customer_name, p.product_name, o.total_amount
from CUSTOMERS c 
INNER JOIN orders o 
on o.customer_id = c.customer_id 
INNER JOIN PRODUCTS p 
on o.product_id =p.product_id
where total_amount > 20000
order by total_amount desc
limit 5 ; 

SELECT c.city, SUM(o.total_amount) AS total_sales
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.city
ORDER BY total_sales DESC
LIMIT 3;


 
select * from customers;
select * from orders;
select * from products;

