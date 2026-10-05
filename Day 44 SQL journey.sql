CREATE DATABASE school_db;
USE school_db;

CREATE TABLE students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(30),
  city VARCHAR(30)
);

CREATE TABLE teachers (
  teacher_id INT PRIMARY KEY,
  teacher_name VARCHAR(30),
  subject_area VARCHAR(30)
);

CREATE TABLE courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(30),
  teacher_id INT,
  fees INT
);

CREATE TABLE enrollments (
  enroll_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  marks INT
);

INSERT INTO students VALUES
(1, 'Aman', 'Meerut'),
(2, 'Bhavna', 'Delhi'),
(3, 'Chirag', 'Meerut'),
(4, 'Divya', 'Noida'),
(5, 'Esha', 'Delhi'),
(6, 'Farhan', 'Noida');

INSERT INTO teachers VALUES
(1, 'Sharma', 'Finance'),
(2, 'Verma', 'Maths'),
(3, 'Iyer', 'Computers'),
(4, 'Khan', 'Economics');

INSERT INTO courses VALUES
(101, 'Accounting', 1, 5000),
(102, 'Statistics', 2, 4000),
(103, 'SQL Basics', 3, 6000),
(104, 'Excel', 3, 3500),
(105, 'Python', NULL, 7000),
(106, 'Banking', 1, 4500);

INSERT INTO enrollments VALUES
(1, 1, 101, 78),
(2, 1, 103, 85),
(3, 2, 101, 66),
(4, 2, 102, 72),
(5, 3, 103, 90),
(6, 3, 104, 58),
(7, 4, 102, 81),
(8, 4, 103, 74),
(9, 5, 104, 69),
(10, 5, 105, 88),
(11, 1, 104, 92),
(12, 2, 103, 60);

select * from courses;
select * from enrollments;
select * from students;
select * from teachers ;

select student_name, course_id, marks
from students s
INNER JOIN ENROLLMENTS e
ON s.student_id = e.student_id;

select course_name, teacher_name
from courses c
INNER JOIN TEACHERS t
on c.teacher_id = t.teacher_id;

select student_name, course_id
from students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id;

select student_name
from students s
left join enrollments e 
on s.student_id = e.student_id
where e.enroll_ID IS NULL;

select c.course_id, e.student_id
from enrollments e 
RIGHT JOIN courses c 
ON e.course_id = c.course_id;

select t.teacher_name, c.course_name
from courses c
RIGHT JOIN teachers t
on c.teacher_id = t.teacher_id;

select s.student_name, c.course_name, e.marks
from students s 
INNER JOIN ENROLLMENTS e 
ON s.student_id = e.student_id
INNER JOIN COURSES c
on e.course_id = c.course_id 
where e.marks > 70;

select c.course_name, count(e.enroll_id) as total_students
from courses c
Left join enrollments e
on c.course_id = e.course_id
GROUP BY c.course_name ;

select s.student_name, c.course_name, t.teacher_name
from students S 
INNER JOIN enrollments e
on s.student_id = e.student_id
INNER JOIN Courses c
on e.course_id = c.course_id
 LEFT JOIN teachers t
 ON c.teacher_id = t.teacher_id ;
 
 SELECT t.teacher_name, AVG(e.marks) AS avg_marks
FROM teachers t
LEFT JOIN courses c
ON t.teacher_id = c.teacher_id
LEFT JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY t.teacher_name;

