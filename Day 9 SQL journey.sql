  create database xcompany;
 
 USE xcompany;
CREATE TABLE Online_Sales (
    Sale_ID INT,
    Product_Name VARCHAR(50),
    Quantity_Sold INT,
    Amount DECIMAL(10, 2),
    Sale_Date DATE
);

CREATE TABLE Retail_Store_Sales (
    Transaction_ID INT,
    Product_Name VARCHAR(50),
    Quantity_Sold INT,
    Revenue DECIMAL(10, 2),
    Sale_Date DATE
);

INSERT INTO Online_Sales (Sale_ID, Product_Name, Quantity_Sold, Amount, Sale_Date) VALUES
(101, 'Laptop', 2, 2400.00, '2026-08-01'),
(102, 'Mouse', 5, 125.00, '2026-08-02'),
(103, 'Keyboard', 3, 225.00, '2026-08-03'),
(104, 'Monitor', 1, 300.00, '2026-08-04'); 

INSERT INTO Retail_Store_Sales (Transaction_ID, Product_Name, Quantity_Sold, Revenue, Sale_Date) VALUES
(501, 'Desk Chair', 4, 600.00, '2026-08-01'),
(502, 'Mouse', 2, 50.00, '2026-08-02'),
(503, 'Monitor', 1, 300.00, '2026-08-04'), 
(504, 'Headphones', 10, 500.00, '2026-08-05');

select * from online_sales;

select * from  Retail_store_sales;
-- if you want to find a product name which quantity sold is > 4 ?

select Product_name, quantity_sold from retail_store_sales
where quantity_sold > 4;

select Product_name, Quantity_sold from Retail_store_sales
UNION 
Select Product_name, Quantity_sold from online_sales;