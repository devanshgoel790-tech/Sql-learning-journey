use hyderabad_school;

select * from student_performance;

select name, marks, attendance  FROM student_performance
where department = "IT"
order by marks desc;

select name, attendance, department from student_performance
where attendance between 85 and 95
order by attendance asc
limit 7;

select department,count(student_id) as total_student from student_performance
group by department
order by total_student desc;

select department, avg(attendance)as avg_attendance from student_performance
group by department
order by avg_attendance desc;

select department, sum(marks) as total_marks from student_performance
group by department
order by total_marks desc
limit 1;

select department, count(student_id)as student_count from student_performance
group by department
having count(student_id) > 5
order by student_count desc;

select department, avg(marks) as avg_marks, avg(attendance) as avg_attendance, count(student_id) as student_count
from student_performance
group by department
having avg(marks)> 78 and avg(attendance) > 82
order by avg_marks desc;

select department, name, marks, attendance from student_performance
where department = "finance" and marks >= 80 and attendance >= 85
order by marks desc
limit 5;

select department, (avg(marks) + avg(marks + attendance))/2  as avg_performance from student_performance
group by department
order by avg_performance desc
limit 1;








