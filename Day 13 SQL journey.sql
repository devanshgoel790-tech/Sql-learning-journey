CREATE database if not exists xcompany;
use xcompany;

CREATE TABLE xcompany_expenses (
    expense_id INT,
    department VARCHAR(50),
    category VARCHAR(50),
    amount DECIMAL(10, 2),
    payment_method VARCHAR(30),
    expense_date DATE
);

INSERT INTO xcompany_expenses 
(expense_id, department, category, amount, payment_method, expense_date) 
VALUES
(1, 'Marketing', 'Software', 150.00, 'Credit Card', '2026-08-01'),
(2, 'Sales', 'Travel', 1200.00, 'Corporate Card', '2026-08-03'),
(3, 'Engineering', 'Software', 450.00, 'Credit Card', '2026-08-05'),
(4, 'Marketing', 'Advertising', 2500.00, 'Bank Transfer', '2026-08-10'),
(5, 'HR', 'Training', 800.00, 'Credit Card', '2026-08-12'),
(6, 'Engineering', 'Hardware', 3200.00, 'Bank Transfer', '2026-08-15'),
(7, 'Sales', 'Entertainment', 350.00, 'Corporate Card', '2026-08-18'),
(8, 'Marketing', 'Events', 5000.00, 'Bank Transfer', '2026-08-20'),
(9, 'HR', 'Office Supplies', 75.00, 'Petty Cash', '2026-08-22'),
(10, 'Engineering', 'Software', 1200.00, 'Credit Card', '2026-08-25');


select * from xcompany_expenses;

select department, category, amount as expenses from xcompany_expenses
where amount between  250 and 1500;

select * from xcompany_expenses
where department = "Marketing";

select amount as expenses, department from xcompany_expenses
where amount  > 1000;

select expense_id ,payment_method, category, amount from xcompany_expenses
where payment_method = "Credit card";

select * from xcompany_expenses
where department = "Engineering" and category = "software"
having amount > 1000;

select * from xcompany_expenses
where department = "Engineering" and CATEGORY = "software";

select * from xcompany_expenses
where department = "sales" or CATEGORY = "HR";

SELECT * FROM XCOMPANY_EXPENSES
WHERE AMOUNT <= 500;

SELECT EXPENSE_ID, DEPARTMENT, PAYMENT_METHOD FROM XCOMPANY_EXPENSES
WHERE PAYMENT_METHOD != "BANK TRANSFER";

SELECT * FROM XCOMPANY_EXPENSES
WHERE AMOUNT > 500 AND PAYMENT_METHOD = "BANK TRANSFER";

