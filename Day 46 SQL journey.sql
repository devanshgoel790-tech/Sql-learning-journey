CREATE DATABASE  IF NOT EXISTS library_db;
USE library_db;

CREATE TABLE members (
  member_id INT PRIMARY KEY,
  member_name VARCHAR(30),
  city VARCHAR(30)
);

CREATE TABLE books (
  book_id INT PRIMARY KEY,
  title VARCHAR(40),
  author VARCHAR(30)
);

CREATE TABLE borrowings (
  borrow_id INT PRIMARY KEY,
  member_id INT,
  book_id INT,
  borrow_date DATE
);

INSERT INTO members VALUES
(1, 'Aarav', 'Meerut'),
(2, 'Diya', 'Delhi'),
(3, 'Kabir', 'Noida'),
(4, 'Isha', 'Meerut'),
(5, 'Rohan', 'Delhi'),
(6, 'Mira', 'Noida');

INSERT INTO books VALUES
(101, 'Zero to One', 'Peter Thiel'),
(102, 'Atomic Habits', 'James Clear'),
(103, 'Rich Dad Poor Dad', 'Robert Kiyosaki'),
(104, 'The Psychology of Money', 'Morgan Housel'),
(105, 'Deep Work', 'Cal Newport'),
(106, 'Case in Point', 'Marc Cosentino');

INSERT INTO borrowings VALUES
(1, 1, 101, '2026-09-01'),
(2, 1, 102, '2026-09-05'),
(3, 2, 102, '2026-09-07'),
(4, 3, 103, '2026-09-10'),
(5, 4, 104, '2026-09-12'),
(6, 2, 105, '2026-09-15'),
(7, 5, 101, '2026-09-18'),
(8, NULL, 103, '2026-09-20'),
(9, 3, NULL, '2026-09-22');

select m.member_name, b.borrow_date
from members m 
INNER JOIN borrowings b 
ON m.member_id = b.member_id;

select b.title , bd.borrow_date
from books b 
INNER JOIN borrowings bd
on b.book_id = bd.book_id;

select m.member_name, m.member_id, bd.borrow_date
from members m 
LEFT JOIN borrowings bd 
on m.member_id = bd.member_id ;

select b.title, bd.borrow_id
from books b 
LEFT JOIN borrowings bd
on b.book_id = bd.book_id ;

SELECT m.member_name, bd.borrow_date
from members m 
RIGHT JOIN borrowings bd 
on m.member_id = bd.member_id ;

select b.title, bd.borrow_date 
from borrowings bd
RIGHT JOIN books b 
on bd.book_id = b.book_id;


select m.member_name, b.title, bd.borrow_date
from members m 
INNER JOIN borrowings bd
on m.member_id = bd.member_id 
INNER JOIN books b 
on bd.book_id = b.book_id;

select m.member_name, b.title 
from members m 
LEFT JOIN  borrowings bd
ON m.member_id = bd.member_id
left join books b
on bd.book_id = b.book_id; 

select m.member_name, bd.borrow_date
from members m 
LEFT JOIN borrowings bd 
on m.member_id = bd.member_id 
UNION 
 select m.member_name, bd.borrow_date
from members m 
RIGHT JOIN borrowings bd 
on m.member_id = bd.member_id ;

select b.title, bd.borrow_date
from books b 
LEFT JOIN borrowings bd
ON b.book_id = bd.book_id
UNION 
select b.title, bd.borrow_date
from books b 
RIGHT JOIN borrowings bd
ON b.book_id = bd.book_id;




select * from books;
select * from borrowings;
select * from members;
