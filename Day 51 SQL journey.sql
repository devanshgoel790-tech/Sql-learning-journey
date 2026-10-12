DROP DATABASE IF EXISTS ipo_db;
CREATE DATABASE ipo_db;
USE ipo_db;

CREATE TABLE ipos (
    ipo_id INT PRIMARY KEY,
    company_name VARCHAR(40),
    sector VARCHAR(30),
    issue_price INT,
    listing_price INT
);

CREATE TABLE applicants (
    applicant_id INT PRIMARY KEY,
    applicant_name VARCHAR(30),
    city VARCHAR(30)
);

CREATE TABLE applications (
    application_id INT PRIMARY KEY,
    applicant_id INT,
    ipo_id INT,
    shares_applied INT,
    shares_allotted INT,
    status VARCHAR(15)
);

INSERT INTO ipos VALUES
(1, 'NovaTech',   'IT',        400, 520),
(2, 'GreenVolt',  'Energy',    120, 108),
(3, 'SafeLife',   'Insurance', 300, 345),
(4, 'QuickMart',  'Retail',    250, 310),
(5, 'MediCore',   'Pharma',    180, 171),
(6, 'UrbanBuild', 'Infra',      90, 117),
(7, 'FinEdge',    'Banking',   500, 560),
(8, 'SkyJet',     'Aviation',  200, NULL);

INSERT INTO applicants VALUES
(1, 'Ananya', 'Meerut'),
(2, 'Vikram', 'Delhi'),
(3, 'Sneha',  'Mumbai'),
(4, 'Rahul',  'Meerut'),
(5, 'Pooja',  'Delhi'),
(6, 'Arjun',  'Pune'),
(7, 'Kriti',  'Noida'),
(8, 'Sameer', 'Mumbai');

INSERT INTO applications VALUES
(1,  1, 1, 30,  30,  'Allotted'),
(2,  1, 2, 50,  0,   'Not Allotted'),
(3,  1, 3, 40,  40,  'Allotted'),
(4,  2, 1, 35,  0,   'Not Allotted'),
(5,  2, 4, 60,  60,  'Allotted'),
(6,  2, 6, 100, 100, 'Allotted'),
(7,  3, 1, 30,  30,  'Allotted'),
(8,  3, 5, 50,  50,  'Allotted'),
(9,  3, 7, 20,  0,   'Not Allotted'),
(10, 4, 2, 50,  50,  'Allotted'),
(11, 4, 3, 40,  40,  'Allotted'),
(12, 4, 4, 55,  0,   'Not Allotted'),
(13, 5, 6, 100, 100, 'Allotted'),
(14, 5, 7, 20,  20,  'Allotted'),
(15, 5, 1, 30,  30,  'Allotted'),
(16, 6, 3, 40,  0,   'Not Allotted'),
(17, 6, 5, 50,  50,  'Allotted'),
(18, 3, 6, 100, 100, 'Allotted');

select * from applicants; 
select * from applications;
select * from ipos;

select i.company_name, i.issue_price 
from ipos i 
where  i.issue_price > 200
order by i.issue_price desc ;

select ac.applicant_name, i.company_name, a.shares_allotted
from  applicants ac
INNER JOIN applications a
ON ac.applicant_id = a.applicant_id 
INNER JOIN ipos i 
on a.ipo_id = i.ipo_id
where status = 'Allotted'  
order by ac.applicant_name asc ,
         i.company_name asc;
         
select ac.applicant_name, i.company_name, (a.shares_applied * i.issue_price)as amount_applied
from applicants ac 
INNER  JOIN applications a 
ON ac.applicant_id = a.applicant_id
INNER JOIN ipos i 
on a.ipo_id = i.ipo_id 
ORDER BY amount_applied DESC
LIMIT 3; 

SELECT i.company_name, sum(a.shares_applied)as total_shares_applied 
from ipos i 
INNER JOIN applications a 
on i.ipo_id = a.ipo_id 
GROUP BY  i.company_name
ORDER BY total_shares_applied DESC ;

select i.sector, sum(a.shares_allotted) as total_alloted
from ipos i 
LEFT JOIN applications a 
ON i.ipo_id = a.ipo_id 
group by i.sector
Having   sum(a.shares_allotted) > 100;

select i.ipo_id , i.company_name ,
 CASE WHEN listing_price > issue_price THEN 'Profit' 
      WHEN listing_price < issue_price THEN 'Loss'
     WHEN listing_price = issue_price THEN 'Flat'
ELSE 'EMPTY'
END AS listing_results
from ipos i
order by i.company_name desc ;

select i.company_name
from ipos i 
LEFT JOIN applications a
 ON i.ipo_id = a.ipo_id 
where a.application_id IS NULL;

select * from applicants; 
select * from applications;
select * from ipos ;

