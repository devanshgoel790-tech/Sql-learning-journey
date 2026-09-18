
CREATE DATABASE hospital_practice;
USE hospital_practice;

CREATE TABLE hospital_records (
    record_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    department VARCHAR(50),
    doctor_name VARCHAR(50),
    city VARCHAR(30),
    treatment_type VARCHAR(50),
    treatment_cost DECIMAL(10,2),
    treatment_days INT,
    satisfaction_score DECIMAL(4,2)
);

INSERT INTO hospital_records
(record_id, patient_name, department, doctor_name, city, treatment_type, treatment_cost, treatment_days, satisfaction_score)
VALUES
(1, 'Rohan', 'Cardiology', 'Dr. Mehta', 'Delhi', 'Heart Checkup', 12000, 2, 8.5),
(2, 'Ananya', 'Neurology', 'Dr. Sharma', 'Mumbai', 'Brain Scan', 18000, 3, 9.1),
(3, 'Vivek', 'Orthopedics', 'Dr. Rao', 'Pune', 'Knee Treatment', 25000, 5, 8.2),
(4, 'Priya', 'Pediatrics', 'Dr. Kapoor', 'Delhi', 'Child Checkup', 6000, 1, 9.3),
(5, 'Arjun', 'Cardiology', 'Dr. Mehta', 'Mumbai', 'ECG', 8000, 1, 8.0),
(6, 'Sneha', 'Dermatology', 'Dr. Iyer', 'Pune', 'Skin Treatment', 9000, 2, 8.7),
(7, 'Rahul', 'Orthopedics', 'Dr. Rao', 'Delhi', 'Fracture Treatment', 32000, 7, 7.8),
(8, 'Isha', 'Neurology', 'Dr. Sharma', 'Mumbai', 'Migraine Treatment', 11000, 2, 8.9),
(9, 'Karan', 'Pediatrics', 'Dr. Kapoor', 'Pune', 'Child Vaccination', 5000, 1, 9.5),
(10, 'Neha', 'Dermatology', 'Dr. Iyer', 'Delhi', 'Acne Treatment', 7000, 2, 8.4),
(11, 'Aman', 'Cardiology', 'Dr. Verma', 'Pune', 'Heart Surgery', 85000, 10, 9.0),
(12, 'Simran', 'Neurology', 'Dr. Sharma', 'Delhi', 'Brain Scan', 18000, 3, 8.6),
(13, 'Yash', 'Orthopedics', 'Dr. Rao', 'Mumbai', 'Knee Treatment', 25000, 5, 8.8),
(14, 'Meera', 'Pediatrics', 'Dr. Kapoor', 'Delhi', 'Child Checkup', 6000, 1, 9.2),
(15, 'Kabir', 'Dermatology', 'Dr. Iyer', 'Mumbai', 'Skin Treatment', 9000, 2, 8.1),
(16, 'Tanya', 'Cardiology', 'Dr. Verma', 'Delhi', 'Heart Checkup', 12000, 2, 8.9),
(17, 'Dev', 'Neurology', 'Dr. Sharma', 'Pune', 'Migraine Treatment', 11000, 2, 8.3),
(18, 'Riya', 'Orthopedics', 'Dr. Rao', 'Delhi', 'Fracture Treatment', 32000, 7, 8.0),
(19, 'Aditya', 'Pediatrics', 'Dr. Kapoor', 'Mumbai', 'Child Vaccination', 5000, 1, 9.6),
(20, 'Nisha', 'Dermatology', 'Dr. Iyer', 'Pune', 'Acne Treatment', 7000, 2, 8.8),
(21, 'Varun', 'Cardiology', 'Dr. Mehta', 'Mumbai', 'ECG', 8000, 1, 7.9),
(22, 'Aditi', 'Neurology', 'Dr. Sharma', 'Delhi', 'Brain Scan', 18000, 3, 9.0),
(23, 'Manav', 'Orthopedics', 'Dr. Rao', 'Pune', 'Knee Treatment', 25000, 5, 8.5),
(24, 'Pooja', 'Pediatrics', 'Dr. Kapoor', 'Mumbai', 'Child Checkup', 6000, 1, 9.4),
(25, 'Sahil', 'Dermatology', 'Dr. Iyer', 'Delhi', 'Skin Treatment', 9000, 2, 8.6);

select * from hospital_records;

select doctor_name, sum(treatment_cost) as total_treatment_cost, count(patient_name) as number_of_patient from hospital_records
group by doctor_name
order by total_treatment_cost desc;

select city, avg(treatment_cost) as avg_treatment_cost from hospital_records
group by city
having avg_treatment_cost > 12000
order by avg_treatment_cost desc;

select department, 
				sum(treatment_cost) as total_treatment_cost, 
				avg(treatment_cost) as avg_treatment_cost, 
				min(treatment_cost)as min_treatment_cost,
				MAX(treatment_cost) as max_treatment_cost 
from hospital_records
group by department
Having MAX(treatment_cost) - min(treatment_cost) > 20000;


select doctor_name, 
                   count(patient_name)as number_of_patients, 
                   sum(treatment_cost)as total_treatment_cost, 
                   avg(treatment_cost)as avg_treatment_cost
from hospital_records 
group by doctor_name
having count(patient_name) > 4
order by number_of_patients desc;

select treatment_type, 
                     count(patient_name)as number_of_patient,
                     sum(treatment_cost) as total_treatment_cost , 
					avg(treatment_cost)as avg_treatment_cost 
from hospital_records
group by treatment_type
having count(patient_name) >= 3 and avg(treatment_cost) > 10000
order by total_treatment_cost desc;

select city,
           count(patient_name)as number_of_patient,
	       sum(treatment_cost) as total_treatment_cost , 
		   avg(treatment_cost)as avg_treatment_cost ,
           avg(satisfaction_score) as avg_satisfaction_score
from hospital_records
group by city
having avg(satisfaction_score) > 8.5 and total_treatment_cost > 100000
order by total_treatment_cost desc;

