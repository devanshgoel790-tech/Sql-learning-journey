create database If not exists companydev;
USE companydev;

create table customerinfo(
customer_id int primary key,
name varchar(100),
payment varchar(80),
city varchar(100)
);
 insert into customerinfo
 (customer_id, name, payment, city)
 values
(101,"olivia Barrett", "netbanking", "Porland"),
(102,"Ethan Sinclair", "credit card", "Miami"),
(103,"Maya Hernandez", "credit card", "Seattle"),
(104,"Liam Donovan", "netbanking", "Denver"),
(105,"Sophia Nguyen", "credit card", "Nwe Orleans"),
(106,"Caleb Foster", "debit card", "Minneapolis"),
(107,"Ava Patel", "debit card", "Phoenix"),
(108,"Lucas Carter", "netbanking", "Boston"),
(109,"Isabella Martinez", "netbanking", "Nashville"),
(110,"Jackson Brooks", "credit card", "Boston");

select * from customerinfo;
-- for the given table find the total payment according to each payment method

select payment,count(name) from customerinfo
group by payment;