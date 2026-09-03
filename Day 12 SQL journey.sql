CREATE DATABASE IF NOT EXISTS fpna_learning;
USE fpna_learning;

-- TABLE 1: Chart of Accounts (GL)
CREATE TABLE chart_of_accounts (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(100),
    account_type VARCHAR(30),
    department VARCHAR(30)
);

INSERT INTO chart_of_accounts VALUES
(5001, 'Sales Revenue', 'Revenue', 'Sales'),
(5002, 'Service Revenue', 'Revenue', 'Service'),
(6001, 'Salary Expense', 'Expense', 'HR'),
(6002, 'Travel Expense', 'Expense', 'Sales'),
(6003, 'Software Licenses', 'Expense', 'IT'),
(6004, 'Marketing Expense', 'Expense', 'Marketing'),
(6005, 'Utilities', 'Expense', 'Operations'),
(6006, 'Office Supplies', 'Expense', 'Operations');

select * from chart_of_accounts;

-- TABLE 2: Monthly Budget
CREATE TABLE monthly_budget (
    budget_id INT PRIMARY KEY,
    account_id INT,
    month_year VARCHAR(10),
    budgeted_amount DECIMAL(12, 2),
    FOREIGN KEY (account_id) REFERENCES chart_of_accounts(account_id)
);

INSERT INTO monthly_budget VALUES
(1, 5001, '2026-09', 500000),
(2, 5002, '2026-09', 100000),
(3, 6001, '2026-09', 150000),
(4, 6002, '2026-09', 50000),
(5, 6003, '2026-09', 25000),
(6, 6004, '2026-09', 30000),
(7, 6005, '2026-09', 15000),
(8, 6006, '2026-09', 10000),
(9, 5001, '2026-10', 550000),
(10, 5002, '2026-10', 110000),
(11, 6001, '2026-10', 160000),
(12, 6002, '2026-10', 55000);

select * from monthly_budget;

-- TABLE 3: Actual Transactions
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATE,
    amount DECIMAL(12, 2),
    description VARCHAR(100),
    FOREIGN KEY (account_id) REFERENCES chart_of_accounts(account_id)
);

INSERT INTO transactions VALUES
(1001, 5001, '2026-09-01', 45000, 'Product Sales - ABC Corp'),
(1002, 5001, '2026-09-05', 52000, 'Product Sales - XYZ Ltd'),
(1003, 5002, '2026-09-03', 12000, 'Service Revenue - Consulting'),
(1004, 6001, '2026-09-05', 15000, 'Salary Payroll'),
(1005, 6002, '2026-09-10', 8000, 'Travel - Sales Conference'),
(1006, 6003, '2026-09-08', 5000, 'Software License Renewal'),
(1007, 6004, '2026-09-12', 7000, 'Marketing Campaign'),
(1008, 6005, '2026-09-15', 2000, 'Electricity Bill'),
(1009, 5001, '2026-09-18', 48000, 'Product Sales - Tech Co'),
(1010, 6001, '2026-09-20', 15000, 'Salary Payroll'),
(1011, 6002, '2026-09-22', 6500, 'Travel - Client Visit'),
(1012, 5002, '2026-09-25', 10000, 'Service Revenue - Training'),
(1013, 6003, '2026-09-28', 4000, 'Cloud Services'),
(1014, 6006, '2026-09-30', 1500, 'Office Supplies'),
(1015, 5001, '2026-10-02', 50000, 'Product Sales - Global Inc'),
(1016, 6001, '2026-10-05', 15500, 'Salary Payroll'),
(1017, 6004, '2026-10-08', 8000, 'Digital Marketing'),
(1018, 5002, '2026-10-10', 11000, 'Service Revenue - Support');

-- Verify data
SELECT * FROM chart_of_accounts;
SELECT * FROM monthly_budget;
SELECT * FROM transactionS;



select transaction_id, amount from transactions
where amount > 10000;

select sum(amount) from transactions
where transaction_date like "2026-09%";


select sum(amount),account_id from transactions
group by ACCOUNT_ID;

