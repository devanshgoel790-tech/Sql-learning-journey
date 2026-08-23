CREATE DATABASE COLLEGE;
USE COLLEGE;

CREATE TABLE STUDENT (
rollno INT PRIMARY KEY,
name VARCHAR (50)
);

select * from student;

INSERT INTO STUDENT (rollno, name) values
(101, "karan"),
(102, "arjun"),
(103, "ram");


INSERT INTO STUDENT (rollno, name) values
(104, "shyam");

CREATE DATABASE companyXYZ;

USE companyXYZ;

CREATE TABLE EMPLOYEE (
ID INT PRIMARY KEY,
name varchar (100),
salary INT NOT NULL
);



INSERT INTO EMPLOYEE (id, name, salary) values
(1, "adam", 25000),
(2, "bob",30000),
(3, "casey",40000);

select * from employee;