CREATE DATABASE COLLEGE;
USE COLLEGE;

CREATE TABLE STUDENT(
id INT PRIMARY KEY,
name VARCHAR(50)
);

INSERT INTO STUDENT (id, name)
values 
(101, "adam"),
(102, "bob"),
(103, "casey");

create table course(
id INT PRIMARY KEY,
COURSE VARCHAR(50)
);


INSERT INTO course (id, course) values
(102, "english"),
(105, "math"),
(106, "science"),
(107, "computer science");

select * from student;
select * from course;


select * from student AS s
inner join course AS C
on s.id = C.id;


update  course
set id = 103
where id =106;


select * from student as s
left join course as C
ON s.id = c.id; 

select * from student as s
RIGHT JOIN course as c
on s.id = c.id;

select * from student as a
left join course as b
on a.id = b.id
UNION
SELECT * FROM student as a
RIGHT JOIN course as b
on a.id = b.id;


