CREATE DATABASE COLLEGE;
USE COLLEGE;

CREATE TABLE STUDENT (
rollno INT PRIMARY KEY,
name VARCHAR(50),
marks INT NOT NULL,
grade VARCHAR(1),
CITY VARCHAR (20)
);

INSERT INTO student (rollno, name, marks, grade, city) VALUES
(101, "anil", 78, "C", "Pune"),
(102, "bhumika", 93, "A", "Mumbai"),
(103, "chetan", 85, "B", "Mumbai"),
(104, "dhruv", 96, "A", "Delhi"),
(105, "emanuel", 12, "F", "Delhi"),
(106, "farah", 82, "B", "Delhi");

-- select * from student WHERE MARKS > 80;

-- SELECT * FROM STUDENT WHERE marks >80 and  CITY = "Mumbai";

select * FROM student where marks +10> 100;


select * from student where marks >90 and city ="mumbai";
select * from student where marks >90 or city ="mumbai";
select * from student where marks between 80 and 90;
 select * from student where city in ("Delhi","Mumbai");
select * from student WHERE MARKS > 75 LIMIT 3;
SELECT * FROM STUDENT ORDER BY marks desc limit 4;

select * from student;