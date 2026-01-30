create database healthcare_data;
use healthcare_data;


#Average Length of Stay (ALOS)

select department,round(avg(datediff(discharge_date,admission_date)),2) as avg_length_of_stay
from admissions a join discharges d on a.admission_id = d.admission_id
group by department;

#Bed Occupancy Rate

select department,round((sum(occupied_beds) * 100.0)/sum(total_beds),2) AS bed_occupancy_rate from beds
group by department;

#Patient Admission & Discharge Counts

select department,count(distinct admission_id) as total_admissions,
count(distinct discharge_id) as total_discharges from admissions a left join discharges d
on a.admission_id = d.admission_id
group by department;

#Readmission Rate (30 Days)

select department,round(count(case when readmitted_within_30_days = 'Yes' then 1 end) * 100.0/count(*),2)as readmission_rate_30_days
from admissions
group by department;

#Procedure Volume

select department,count(procedure_id) as total_procedures from procedures
group by department;

#Emergency vs Scheduled Cases

select department,case_type,count(*)as case_count from admissions
group by department, case_type;

#Doctor Utilization (% Time Booked)

select doctor_id,round((sum(booked_hours) * 100.0) /sum(available_hours),2)as doctor_utilization_percentage
from doctor_schedule
group by doctor_id;

#Cost per Patient & Billing Breakdown

select department,round(avg(total_bill_amount), 2)as avg_cost_per_patient,sum(total_bill_amount)as total_revenue from billing
group by department;

#Patient Outcome Classification

select department,outcome_status,count(*) as patient_count from outcomes
group by department, outcome_status;





