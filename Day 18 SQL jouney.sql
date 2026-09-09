create database if not exists HYDERABAD_SCHOOL;
USE HYDERABAD_SCHOOL;

CREATE TABLE student_performance (
    student_id INT,
    name VARCHAR(50),
    department VARCHAR(30),
    semester INT,
    marks INT,
    attendance INT,
    assignment_score INT
);

INSERT INTO student_performance VALUES
(1, 'Devansh', 'Finance', 1, 85, 92, 88),
(2, 'Arjun', 'Finance', 1, 72, 80, 75),
(3, 'Priya', 'Finance', 1, 95, 95, 92),
(4, 'Rahul', 'IT', 1, 65, 70, 68),
(5, 'Neha', 'IT', 1, 88, 88, 85),
(6, 'Vikram', 'Finance', 1, 78, 85, 80),
(7, 'Ananya', 'IT', 1, 92, 90, 91),
(8, 'Rohan', 'Finance', 1, 55, 60, 58),
(9, 'Sana', 'IT', 1, 80, 82, 78),
(10, 'Amit', 'Finance', 1, 91, 89, 90),
(11, 'Riya', 'IT', 1, 70, 75, 72),
(12, 'Harsh', 'Finance', 1, 82, 86, 84),
(13, 'Zara', 'IT', 1, 60, 65, 62),
(14, 'Karan', 'Finance', 1, 75, 78, 77),
(15, 'Isha', 'IT', 1, 85, 87, 86);

SELECT * FROM STUDENT_PERFORMANCE;

SELECT NAME, MARKS, ATTENDANCE FROM STUDENT_PERFORMANCE
WHERE department = "Finance" and  marks > 80
order by marks asc;

select name, department, attendance from student_performance 
where attendance < 85
order by attendance asc
limit 5;

select department, count(*) as no_of_students from student_performance
group by department 
order by no_of_students desc;

select department, avg(marks) as avg_marks
 from student_performance
group by department
order by avg_marks desc;

select department,sum(attendance) as total_attendance from student_performance
group by department
order by total_attendance desc
limit 2;

select department, avg(marks) as avg_marks from student_performance
group by department
having avg(marks) > 75
order by avg_marks desc;

select department, avg(marks) as avg_marks, avg(attendance) as avg_attendance
 from student_performance
 group by department
 having avg(marks) > 75 and avg(attendance) > 80
 order by avg(marks) desc;
 
 select name, marks, attendance, (marks + attendance)/2 as avg_score
 from student_performance
 where department = "Finance" and marks > 75 and attendance > 80
 order by avg_score desc
 limit 5;

 

