
CREATE DATABASE CustomerAnalytics;
USE CustomerAnalytics;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(30),
    amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Customers VALUES
(1,'Rahul Sharma','Delhi','Delhi','2025-01-15'),
(2,'Priya Verma','Mumbai','Maharashtra','2025-02-10'),
(3,'Aman Gupta','Bangalore','Karnataka','2025-02-18'),
(4,'Sneha Patel','Ahmedabad','Gujarat','2025-03-05'),
(5,'Rohit Mehta','Pune','Maharashtra','2025-03-12'),
(6,'Anjali Singh','Jaipur','Rajasthan','2025-03-20'),
(7,'Karan Malhotra','Chandigarh','Punjab','2025-04-02'),
(8,'Neha Kapoor','Hyderabad','Telangana','2025-04-15'),
(9,'Arjun Rao','Chennai','Tamil Nadu','2025-05-01'),
(10,'Meera Joshi','Lucknow','Uttar Pradesh','2025-05-18'),
(11,'Vikas Yadav','Noida','Uttar Pradesh','2025-06-01'),
(12,'Riya Shah','Surat','Gujarat','2025-06-15');

INSERT INTO Categories VALUES
(1,'Electronics'),
(2,'Furniture'),
(3,'Clothing'),
(4,'Accessories'),
(5,'Home Appliances');

INSERT INTO Products VALUES
(101,'Laptop',1,65000),
(102,'Smartphone',1,35000),
(103,'Headphones',4,2500),
(104,'Office Chair',2,8500),
(105,'Desk',2,12000),
(106,'T-Shirt',3,1200),
(107,'Jeans',3,2500),
(108,'Smart Watch',4,7500),
(109,'Microwave',5,14000),
(110,'Air Conditioner',5,42000),
(111,'Keyboard',4,1800),
(112,'Monitor',1,18000);

INSERT INTO Orders VALUES
(1001,1,'2025-06-01','Completed'),
(1002,2,'2025-06-02','Completed'),
(1003,3,'2025-06-03','Completed'),
(1004,1,'2025-06-05','Pending'),
(1005,4,'2025-06-06','Completed'),
(1006,5,'2025-06-07','Cancelled'),
(1007,6,'2025-06-08','Completed'),
(1008,7,'2025-06-10','Completed'),
(1009,8,'2025-06-12','Pending'),
(1010,9,'2025-06-14','Completed'),
(1011,10,'2025-06-15','Completed'),
(1012,11,'2025-06-16','Completed'),
(1013,12,'2025-06-18','Completed'),
(1014,3,'2025-06-20','Completed'),
(1015,5,'2025-06-21','Pending');

INSERT INTO OrderDetails VALUES
(1,1001,101,1,65000),
(2,1001,103,2,2500),
(3,1002,102,1,35000),
(4,1002,108,1,7500),
(5,1003,104,2,8500),
(6,1003,111,2,1800),
(7,1004,105,1,12000),
(8,1005,106,3,1200),
(9,1005,107,2,2500),
(10,1006,110,1,42000),
(11,1007,109,1,14000),
(12,1007,103,1,2500),
(13,1008,101,1,65000),
(14,1008,112,1,18000),
(15,1009,102,2,35000),
(16,1010,108,2,7500),
(17,1010,111,1,1800),
(18,1011,104,1,8500),
(19,1011,105,1,12000),
(20,1012,106,5,1200),
(21,1013,110,1,42000),
(22,1013,109,1,14000),
(23,1014,101,1,65000),
(24,1014,103,1,2500),
(25,1015,112,2,18000);

INSERT INTO Payments VALUES
(501,1001,'2025-06-01','Credit Card',70000),
(502,1002,'2025-06-02','UPI',42500),
(503,1003,'2025-06-03','Credit Card',20600),
(504,1004,'2025-06-05','UPI',12000),
(505,1005,'2025-06-06','Debit Card',8600),
(506,1006,'2025-06-07','Credit Card',42000),
(507,1007,'2025-06-08','UPI',16500),
(508,1008,'2025-06-10','Credit Card',83000),
(509,1009,'2025-06-12','UPI',70000),
(510,1010,'2025-06-14','Debit Card',16800),
(511,1011,'2025-06-15','UPI',20500),
(512,1012,'2025-06-16','Credit Card',6000),
(513,1013,'2025-06-18','Credit Card',56000),
(514,1014,'2025-06-20','UPI',67500);


select * from categories;
select * from customers;
select * from payments;
select * from orders;
select * from orderdetails;
select * from products;


SELECT c.customer_name, o.order_id
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id;

select customer_name, city, order_date
from customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

select p.product_name, c.category_name
from products p
INNER JOIN categories c
on p.category_id = c.category_id;

select order_id, product_name, quantity
from orderdetails od
INNER JOIN products p
on od.product_id = p.product_id;

select * from categories;
select * from customers;
select * from payments;
select * from orders;
select * from orderdetails;
select * from products;

select customer_name, order_id, order_status
from customers c
INNER JOIN ORDERS O
ON c.customer_id = o.customer_id;

SELECT c.customer_name, o.order_id,
       p.product_name, od.quantity
FROM customers c
INNER JOIN orders o
   ON c.customer_id = o.customer_id
INNER JOIN orderdetails od
   ON o.order_id = od.order_id
INNER JOIN products p
   ON od.product_id = p.product_id;

