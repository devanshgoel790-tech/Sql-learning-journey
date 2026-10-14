DROP DATABASE IF EXISTS loans_db;
CREATE DATABASE loans_db;
USE loans_db;

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_name VARCHAR(30),
    loan_type VARCHAR(20),
    amount INT,
    interest_rate DECIMAL(4,1),
    city VARCHAR(30),
    status VARCHAR(10)
);

INSERT INTO loans VALUES
(1,  'Aarav',  'Home',      4500000, 8.5,  'Meerut', 'Active'),
(2,  'Diya',   'Car',       800000,  9.2,  'Delhi',  'Active'),
(3,  'Kabir',  'Personal',  300000,  12.5, 'Mumbai', 'Overdue'),
(4,  'Isha',   'Education', 1200000, 9.8,  'Meerut', 'Active'),
(5,  'Rohan',  'Home',      6000000, 8.4,  'Delhi',  'Active'),
(6,  'Mira',   'Personal',  150000,  13.0, 'Pune',   'Closed'),
(7,  'Neel',   'Car',       950000,  9.0,  'Noida',  'Active'),
(8,  'Tara',   'Home',      3500000, 8.6,  'Mumbai', 'Active'),
(9,  'Vikram', 'Personal',  450000,  12.0, 'Meerut', 'Overdue'),
(10, 'Sneha',  'Education', 900000,  9.5,  'Delhi',  'Closed'),
(11, 'Rahul',  'Car',       700000,  9.4,  'Meerut', 'Active'),
(12, 'Pooja',  'Home',      5200000, 8.3,  'Pune',   'Active'),
(13, 'Arjun',  'Personal',  200000,  12.8, 'Delhi',  'Active'),
(14, 'Kriti',  'Car',       1100000, 8.9,  'Mumbai', 'Closed'),
(15, 'Sameer', 'Education', 1500000, 9.6,  'Meerut', 'Active'),
(16, 'Anita',  'Personal',  350000,  12.2, 'Meerut', 'Overdue'),
(17, 'Dev',    'Home',      4000000, 8.7,  'Delhi',  'Active'),
(18, 'Riya',   'Car',       600000,  9.3,  'Noida',  'Active'),
(19, 'Karan',  'Education', 700000,  9.9,  'Pune',   'Closed'),
(20, 'Nisha',  'Personal',  250000,  12.6, 'Mumbai', 'Active');

CREATE TABLE repayments (
    repayment_id INT PRIMARY KEY,
    loan_id INT,
    paid_amount INT,
    paid_date DATE
);

CREATE TABLE branches (
    branch_id INT PRIMARY KEY,
    city VARCHAR(30),
    manager_name VARCHAR(30)
);

INSERT INTO repayments VALUES
(1,  1,  45000, '2026-07-05'),
(2,  1,  45000, '2026-08-05'),
(3,  2,  15000, '2026-07-10'),
(4,  2,  15000, '2026-08-10'),
(5,  4,  20000, '2026-07-12'),
(6,  5,  60000, '2026-07-15'),
(7,  5,  60000, '2026-08-15'),
(8,  7,  18000, '2026-07-20'),
(9,  8,  35000, '2026-08-01'),
(10, 12, 52000, '2026-08-05'),
(11, 13, 5000,  '2026-08-09'),
(12, 17, 40000, '2026-08-12'),
(13, 99, 7000,  '2026-08-20'),
(14, 15, 25000, '2026-08-14');

INSERT INTO branches VALUES
(1, 'Meerut',  'Anil'),
(2, 'Delhi',   'Sunita'),
(3, 'Mumbai',  'Ramesh'),
(4, 'Pune',    'Kavita'),
(5, 'Lucknow', 'Deepak');

select * from loans;
select * from branches;
select * from repayments;

select * from loans 
where loan_type = 'Home';

select customer_name, amount
from loans 
where amount >  1000000;

select customer_name, city 
from loans 
where city in  ('Meerut','Delhi');

select customer_name, loan_type, amount
from loans 
order by amount desc ;

select customer_name, amount
from loans
order by amount desc 
limit 3 ;

select customer_name, amount
from loans
where status = 'overdue'
order by amount desc ;

select loan_type, count(loan_id)as number_of_loans
from loans
group by loan_type
order by count(loan_id)desc ;

select city, sum(amount)as total_loan_amount
from loans
group by city
order by sum(amount) desc;

select loan_type, sum(amount)as total_amount
from loans 
Group by loan_type
Having  sum(amount) > 4000000
order by sum(amount) desc;

select city, count(loan_id) as count_loan 
from loans  
group by city
Having count(loan_id) > 2 
order by count(loan_id) desc;

select l.customer_name, l.loan_type, r.paid_amount, r.paid_date 
from loans l 
Inner join repayments r 
on l.loan_id = r.loan_id
group by  l.customer_name, l.loan_type, r.paid_amount, r.paid_date 
order by r.paid_amount asc;

select l.customer_name, l.loan_type, r.paid_amount 
 from loans l 
left join repayments r 
on l.loan_id = r.loan_id
order by l.customer_name;

select l.customer_name, l.loan_type
from loans l 
Left join  repayments r 
ON l.loan_id = r.loan_id 
where r.repayment_id IS NULL;

SELECT r.repayment_id,r.paid_amount, l.customer_name
from loans l  
RIGHT JOIN repayments r 
on l.loan_id = r.loan_id 
order by r.repayment_id ; 

select b.city, b.manager_name, l.customer_name
from loans l
RIGHT JOIN branches b 
on l.city = b.city 
order by  b.city, l.customer_name;


select * from loans;
select * from branches;
select * from repayments;
