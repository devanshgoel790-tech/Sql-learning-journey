CREATE DATABASE IF NOT EXISTS loan_ops_db;
USE loan_ops_db;

CREATE TABLE borrowers
 (borrower_id INT PRIMARY KEY,
 borrower_name VARCHAR(20), 
 city VARCHAR(20));
 
INSERT INTO borrowers VALUES
(1,'Anil','Meerut'),
(2,'Meena','Delhi'),
(3,'Rohit','Noida'),
(4,'Sana','Meerut'),
(5,'Vivek','Delhi');

CREATE TABLE loans (
  loan_id INT PRIMARY KEY,
  borrower_id INT, 
  loan_amount INT, 
  status VARCHAR(10), 
  start_date DATE
);
INSERT INTO loans VALUES
(101,1,500000,'Active','2026-01-10'),(102,1,200000,'Closed','2025-06-15'),
(103,2,300000,'Active','2026-03-05'),(104,3,150000,'Defaulted','2025-11-20'),
(105,4,400000,'Active','2026-05-18'),(106,4,100000,'Closed','2025-09-01'),
(107,5,250000,'Active','2026-07-22'),(108,2,120000,'Active','2026-09-09');

CREATE TABLE payments (
  payment_id INT PRIMARY KEY, 
  loan_id INT, 
  pay_date DATE, 
  amount INT,
  FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);
INSERT INTO payments VALUES
(1,101,'2026-02-10',20000),(2,101,'2026-03-10',20000),(3,101,'2026-04-10',20000),
(4,103,'2026-04-05',15000),(5,103,'2026-05-05',15000),(6,105,'2026-06-18',25000),
(7,105,'2026-07-18',25000),(8,107,'2026-08-22',10000),(9,102,'2025-07-15',50000),
(10,106,'2025-10-01',100000),(11,108,'2026-10-09',8000),(12,101,'2026-05-10',20000);

CREATE TABLE credit_limits 
(borrower_id INT PRIMARY KEY, 
credit_limit INT);

INSERT INTO credit_limits VALUES 
(1,600000),
(2,400000),
(3,200000),
(4,500000),
(5,300000);

CREATE TABLE limit_log (
  log_id INT AUTO_INCREMENT PRIMARY KEY, 
  borrower_id INT,
  old_limit INT, 
  new_limit INT, 
  changed_at DATETIME
);

SELECT * FROM borrowers;
SELECT * FROM credit_limits;
SELECT * FROM limit_log;
SELECT * FROM loans;
SELECT * FROM payments;

DELIMITER //
CREATE PROCEDURE get_loans_by_status(IN s VARCHAR(10))
BEGIN
  SELECT loan_id, borrower_id, loan_amount
  FROM loans
  WHERE status = s
  ORDER BY loan_amount DESC;
END //
DELIMITER ;

CALL get_loans_by_status('Active');

DELIMITER //
CREATE PROCEDURE total_paid(IN l INT, OUT total INT)
BEGIN
  SELECT SUM(amount) INTO total
  FROM payments
  WHERE loan_id = l;
END //
DELIMITER ;

CALL total_paid(101, @t);
SELECT @t;

DELIMITER //
CREATE TRIGGER trg_limit_update
AFTER UPDATE ON credit_limits
FOR EACH ROW
BEGIN
  IF OLD.credit_limit <> NEW.credit_limit THEN
    INSERT INTO limit_log (borrower_id, old_limit, new_limit, changed_at)
    VALUES (OLD.borrower_id, OLD.credit_limit, NEW.credit_limit, NOW());
  END IF;
END //
DELIMITER ;

UPDATE credit_limits SET credit_limit = 450000 WHERE borrower_id = 2;
UPDATE credit_limits SET credit_limit = 250000 WHERE borrower_id = 3;

SELECT borrower_id, old_limit, new_limit
FROM limit_log
ORDER BY log_id;

START TRANSACTION;
DELETE FROM payments WHERE loan_id = 101;
ROLLBACK;

SELECT COUNT(*) FROM payments;

CREATE TABLE cities AS SELECT DISTINCT city FROM borrowers;
SELECT * FROM cities ORDER BY city;

INSERT INTO payments VALUES (13, 999, '2026-11-01', 5000);

SELECT b.borrower_name, SUM(p.amount) AS total_paid
FROM borrowers b
INNER JOIN loans l ON b.borrower_id = l.borrower_id
INNER JOIN payments p ON l.loan_id = p.loan_id
GROUP BY b.borrower_id, b.borrower_name
HAVING SUM(p.amount) >= 30000
ORDER BY total_paid DESC;

SELECT l.loan_id, l.loan_amount
FROM loans l
LEFT JOIN payments p ON l.loan_id = p.loan_id
WHERE p.payment_id IS NULL;

SELECT payment_id, pay_date, amount,
       SUM(amount) OVER (ORDER BY pay_date, payment_id) AS running_total
FROM payments
WHERE loan_id = 101
ORDER BY pay_date, payment_id;