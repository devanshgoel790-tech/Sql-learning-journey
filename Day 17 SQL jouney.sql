create database college;
use college;

create table student (
rollno INT PRIMARY KEY,
name VARCHAR(50),
marks INT NOT NULL,
GRADE varchar(1),
city VARCHAR(20)
);

CREATE TABLE dept( 
id int PRIMARY KEY,
NAME VARCHAR(50)
);


create table teacher (
ID INT PRIMARY KEY,
name VARCHAR(50),
dept_id int,
FOREIGN KEY (DEPT_ID) REFERENCES dept (id)
);
