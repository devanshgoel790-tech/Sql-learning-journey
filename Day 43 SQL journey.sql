USE CustomerAnalytics;

INSERT INTO Customers VALUES
(13, 'Ishita Jain', 'Indore', 'Madhya Pradesh', '2025-07-01'),
(14, 'Kabir Sethi', 'Bhopal', 'Madhya Pradesh', '2025-07-05'),
(15, 'Tanya Roy', 'Kolkata', 'West Bengal', '2025-07-10');

INSERT INTO Categories VALUES
(6, 'Stationery');

INSERT INTO Products VALUES
(113, 'Notebook', 6, 150),
(114, 'Printer', 1, 12000);

INSERT INTO Orders VALUES
(1016, 13, '2025-06-22', 'Completed'),
(1017, 2, '2025-06-23', 'Completed');

INSERT INTO OrderDetails VALUES
(26, 1016, 113, 4, 150),
(27, 1017, 102, 1, 35000);


 select * from categories;
select * from customers;
select * from orderdetails;
select * from orders;
select * from payments;
select * from products;

select customer_name,order_id
 from customers C
 INNER JOIN orders o
 on c.customer_id = o.customer_id;
 
 select product_name, category_name
 from products p
 INNER JOIN categories c
 on p.category_id = c.category_id;
 
 select order_id, product_name, quantity
 from orderdetails od
 INNER JOIN products p
 on od.product_id = p.product_id;
 
 select customer_name,order_date, order_status
 from customers c
 INNER JOIN ORDERS o
 on c.customer_id = o.customer_id;
 
 select product_name, category_name, unit_price
from products p
INNER JOIN categories c
on p.category_id = c.category_id
INNER JOIN orderdetails od
on p.product_id = od.product_id 
where category_name = 'Electronics';

SELECT
    c.customer_name,
    o.order_id,
    p.product_name,
    od.quantity
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN OrderDetails od
    ON o.order_id = od.order_id
INNER JOIN Products p
    ON od.product_id = p.product_id
WHERE o.order_status = 'Completed';
