use college;

select * from student;

update student
set GRADE = "O"
where GRADE  ="A";


update student
set MARKS = 82
where ROLLNO ="105";

UPDATE STUDENT
SET GRADE ="B"
WHERE MARKS BETWEEN 80 AND 90;

UPDATE STUDENT 
SET MARKS = MARKS+1;


SET SQL_SAFE_UPDATES = 0;