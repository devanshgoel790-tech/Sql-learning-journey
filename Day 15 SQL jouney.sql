create database if not exists ycompany;
use ycompany;

create table salesdata(
id INT PRIMARY KEY,
product_name varchar(50),
category varchar(50),
quantity_sold int,
unit_price decimal(10,2),
sale_date date
);

insert into salesdata values
(1, "smartphone", "Electronics", 2, 800, "2026-08-01"),
(2, "laptop", "Electronics", 1, 1200, "2026-08-01"),
(3, "deskchair","Furniture",2, 150, "2026-08-02"),
(4, "monitor","Electronics",1, 300, "2026-08-02"),
(5, "desklamp", "Homedecor",3, 50,"2026-08-03"),
(6, "mouse","Electronics",5,25,"2026-08-03"),
(7," bookshelf","Furniture",1, 200, "2026-08-04"),
(8, "keyboard","Electronics",2, 45, "2026-08-04"),
(9, "officedesk","Furniture",1,350, "2026-08-05"),
(10,"smartwatch","Electronics",2,200," 2026-08-05");

select * from salesdata;

select count(quantity_sold) as sold from salesdata;C

select distinct category from salesdata;

select sum(quantity_sold * unit_price) as Totalrevenue from salesdata;

SELECT AVG(UNIT_PRICE) FROM SALESDATA;

SELECT PRODUCT_NAME,QUANTITY_SOLD AS SOLD  FROM SALESDATA
WHERE QUANTITY_SOLD > 2;

SELECT PRODUCT_NAME,COUNT(QUANTITY_SOLD)AS SALES FROM SALESDATA
GROUP BY CATEGORY, PRODUCT_NAME;

SELECT COUNT(QUANTITY_SOLD * UNIT_PRICE) AS TOTAL_REVENUE FROM SALESDATA
GROUP BY CATEGORY;

SELECT PRODUCT_NAME,MAX(QUANTITY_SOLD * UNIT_PRICE) AS TOTAL_REVENUE FROM SALESDATA
GROUP BY PRODUCT_NAME
order by TOTAL_REVENUE DESC
LIMIT 1;

SELECT SALE_DATE AS SALE,SUM(QUANTITY_SOLD * UNIT_PRICE) AS TOTAL_REVENUE FROM SALESDATA
GROUP BY SALE_DATE;







