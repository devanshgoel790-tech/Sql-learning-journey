CREATE DATABASE college;
USE college;

CREATE TABLE student (
    rollno INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT NOT NULL,
    grade VARCHAR(1),
    city VARCHAR(20)
);

INSERT INTO student
    (rollno, name, marks, grade, city)
VALUES
    (101, 'anil', 78, 'C', 'Pune'),
    (102, 'bhumika', 93, 'A', 'Mumbai'),
    (103, 'chetan', 85, 'B', 'Mumbai'),
    (104, 'dhruv', 96, 'A', 'Delhi'),
    (105, 'emanuel', 92, 'F', 'Delhi'),
    (106, 'farah', 82, 'B', 'Delhi');
    
select * from student;

select AVG(MARKS) FROM student;


select name, marks from student
where marks > 87.6667;

select name, marks from student
where marks > (select AVG(MARKS) FROM student);

 /* select rollno from student 
 where rollno % 2 =0  */


 SELECT MAX(marks) 
 from (select * from student where city = "mumbai")as temp; 
 
 
 select name from student 
 where city = "delhi";
 
 select max(marks) from student 
 where city = "delhi";
 
