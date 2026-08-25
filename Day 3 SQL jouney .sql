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

select * from student;

SELECT AVG(marks) FROM STUDENT;

SELECT MAX(marks) FROM STUDENT;

select MIN(MARKS) FROM STUDENT;

SELECT avg(MARKS) FROM STUDENT
WHERE marks > 80 and CITY in ("Mumbai", "Delhi");