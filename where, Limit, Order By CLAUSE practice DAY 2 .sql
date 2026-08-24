-- WHERE Clause Practice: Sales Transactions Dataset
-- This is realistic financial data you'll see in FP&A work

-- =====================================================
-- STEP 1: Create the table
-- =====================================================

CREATE DATABASE IF NOT EXISTS fp_a_practice;
USE fp_a_practice;

CREATE TABLE sales_transactions (
    transaction_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    region VARCHAR(20),
    salesperson_name VARCHAR(30),
    sale_amount DECIMAL(10, 2),
    quantity_sold INT,
    sale_date DATE,
    payment_status VARCHAR(15),
    customer_type VARCHAR(20)
);
select * from sales_transactions;
-- =====================================================
-- STEP 2: Insert the data
-- =====================================================

INSERT INTO sales_transactions VALUES
(1001, 'Laptop', 'North', 'Rajesh', 85000.00, 2, '2026-08-01', 'Paid', 'Corporate'),
(1002, 'Mouse', 'South', 'Priya', 1500.00, 50, '2026-08-02', 'Pending', 'Retail'),
(1003, 'Monitor', 'North', 'Amit', 28000.00, 5, '2026-08-03', 'Paid', 'Corporate'),
(1004, 'Keyboard', 'East', 'Neha', 3500.00, 100, '2026-08-04', 'Pending', 'Retail'),
(1005, 'Laptop', 'West', 'Rajesh', 82000.00, 1, '2026-08-05', 'Paid', 'Individual'),
(1006, 'Mouse', 'North', 'Priya', 1200.00, 75, '2026-08-06', 'Paid', 'Retail'),
(1007, 'Monitor', 'South', 'Amit', 29000.00, 4, '2026-08-07', 'Pending', 'Corporate'),
(1008, 'Laptop', 'East', 'Neha', 86000.00, 3, '2026-08-08', 'Paid', 'Corporate'),
(1009, 'Keyboard', 'West', 'Rajesh', 4000.00, 60, '2026-08-09', 'Paid', 'Retail'),
(1010, 'Mouse', 'North', 'Amit', 1500.00, 40, '2026-08-10', 'Pending', 'Individual'),
(1011, 'Monitor', 'East', 'Priya', 27500.00, 3, '2026-08-11', 'Paid', 'Corporate'),
(1012, 'Laptop', 'South', 'Neha', 84500.00, 2, '2026-08-12', 'Paid', 'Individual'),
(1013, 'Keyboard', 'North', 'Rajesh', 3800.00, 50, '2026-08-13', 'Pending', 'Retail'),
(1014, 'Mouse', 'West', 'Amit', 1300.00, 80, '2026-08-14', 'Paid', 'Retail'),
(1015, 'Laptop', 'North', 'Priya', 85500.00, 2, '2026-08-15', 'Paid', 'Corporate');

-- =====================================================
-- VERIFY YOUR DATA
-- =====================================================
SELECT * FROM sales_transactions;

-- You should see 15 transactions with:
-- - transaction_id: 1001-1015
-- - Products: Laptop, Mouse, Monitor, Keyboard
-- - Regions: North, South, East, West
-- - Salesperson: Rajesh, Priya, Amit, Neha
-- - Sale amounts ranging from ₹1,200 to ₹86,000
-- - Quantities: 1-100 units
-- - Dates: Aug 1-15, 2026
-- - Payment Status: Paid or Pending
-- - Customer Type: Corporate, Retail, Individual

-- =====================================================
-- PRACTICE QUESTIONS
-- =====================================================
-- Write the WHERE query for each question below
-- Test each one in MySQL Workbench
-- Copy your successful queries to a file named "Day2_WHERE_Practice.sql"

/*
QUESTION 1 (Basic AND)
Find all transactions where:
- Payment status is "Paid" 
- AND sale_amount is greater than 50,000

Expected: Should return 5-6 rows (high-value paid transactions)
*/

SELECT * FROM sales_transactions
WHERE payment_status = 'Paid' AND sale_amount > 50000;

/*
QUESTION 2 (OR operator)
Find all transactions where:
- Product is "Laptop"
- OR Product is "Monitor"

Expected: Should return 8 rows (all laptops and monitors)
*/

SELECT * FROM sales_transactions
WHERE product_name = 'Laptop' OR product_name = 'Monitor';



/*
QUESTION 3 (IN operator)
Find all transactions where region is either North or East

Expected: Should return 6 rows
*/
select * from sales_transactions
where region in (" NORTH", "east");
-- Write your query here:
SELECT * FROM sales_transactions
WHERE region IN ('North', 'East');

/*
QUESTION 4 (BETWEEN)
Find all transactions where:
- Sale date is between August 5 and August 10, 2026
- Show only transaction_id, product_name, sale_date

Expected: Should return 6 rows
*/

SELECT transaction_id, product_name, sale_date FROM sales_transactions
WHERE sale_date BETWEEN '2026-08-05' AND '2026-08-10';

/*
QUESTION 5 (Complex: AND + OR + NOT)
Find all transactions where:
- Payment status is NOT "Pending"
- AND (Salesperson is "Rajesh" OR region is "East")
- ORDER BY sale_amount descending

Expected: Should return 3-4 rows
*/

SELECT * FROM sales_transactions
where (salesperson_name = 'neha' and region = 'East')
ORDER BY sale_amount DESC;


/*
QUESTION 6 (FP&A Real-World)
You're an FP&A analyst. Find:
- All PAID Corporate transactions
- With sale_amount > 25,000
- Sorted by sale_amount (highest first)

Expected: Should return 3-4 rows (these are key deals)
*/

-- Write your query here:
SELECT * FROM sales_transactions  
WHERE payment_status = 'Paid' 
AND customer_type = 'Corporate'
AND sale_amount > 25000
ORDER BY sale_amount DESC;


/*
QUESTION 7 (LIKE pattern matching)
Find all products that contain the letter "o" (Monitor, Keyboard, Mouse)
Use LIKE with wildcard

Expected: Should return 10 rows
*/

select * from sales_transactions
where product_name in ("monitor","keyboard", "mouse");



/*
QUESTION 8 (Challenge: Multiple conditions)
Find transactions where:
- Region is NOT "West"
- AND quantity_sold >= 50
- AND (payment_status = 'Paid' OR sale_amount > 28000)
- LIMIT 5

Expected: Should return 3-5 rows
*/

-- Write your query here:
SELECT * FROM sales_transactions
WHERE region != 'West'
AND quantity_sold >= 50
AND (payment_status = 'Paid' OR sale_amount > 28000)
LIMIT 5;

