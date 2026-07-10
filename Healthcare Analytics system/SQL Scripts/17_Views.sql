-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics
-- AUTHOR  : Pavani Arudra
-- FILE_17 : Views
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- Dashboard Views

# 1. Hospital overview
create view vw_hospital_overview as
select
v.Visit_ID,
v.Visit_Date,
v.Visit_Type,
v.Visit_Status,
v.Diagnosis,
p.Patient_ID,
concat(p.First_Name, ' ', p.Last_Name) as 'Patient_Name',
timestampdiff(year, p.Date_of_Birth, curdate()) as 'Age',
p.Gender,
d.Doctor_Name,
dep.Department_Name,
b.Amount_Billed,
b.Patient_Paid,
b.Insurance_Covered,
b.Outstanding
from Visit as v
join Patients as p
on v.Patient_ID = p.Patient_ID
join Doctors as d
on v.Doctor_ID = d.Doctor_ID
join Department as dep
on d.Department_ID = dep.Department_ID
left join Billing as b
on v.Visit_ID = b.Visit_ID;

select *
from vw_hospital_overview;

# 2. Executive KPI dashboard
create view vw_executive_kpi as
select
(select count(*) from Patients) as 'Total_Patients',
(select count(*) from Doctors) as 'Total_Doctors',
(select count(*) from Visit) as 'Total_Visits',
(select count(*) from Treatment) as 'Total_Treatments',
(select count(*) from Lab_Test) as 'Total_Lab_Tests',
(select sum(Amount_Billed) from Billing) as 'Total_Revenue',
(select sum(Patient_Paid) from Billing) as 'Patient_Collections',
(select sum(Insurance_Covered) from Billing) as 'Insurance_Collections',
(select sum(Outstanding) from Billing) as 'Outstanding_Balance';

select *
from vw_executive_kpi;

# 3. Department performance
create view vw_department_performance as
select
dep.Department_Name,
count(distinct d.Doctor_ID) as 'Total_Doctors',
count(distinct v.Patient_ID) as 'Total_Patients',
count(v.Visit_ID) as 'Total_Visits',
sum(b.Amount_Billed) as 'Revenue',
round(avg(b.Amount_Billed), 2) as 'Average_Bill'
from Department as dep
left join Doctors as d
on dep.Department_ID = d.Department_ID
left join Visit as v
on d.Doctor_ID = v.Doctor_ID
left join Billing as b
on v.Visit_ID = b.Visit_ID
group by dep.Department_Name;

select *
from vw_department_performance;

# 4. Doctor performance
create view vw_doctor_performance as
select
d.Doctor_ID,
d.Doctor_Name,
dep.Department_Name,
count(distinct v.Patient_ID) as 'Patients_Handled',
count(v.Visit_ID) as 'Total_Visits',
count(t.Treatment_ID) as 'Treatments_Performed',
sum(b.Amount_Billed) as 'Revenue_Generated'
from Doctors as d
left join Department as dep
on d.Department_ID = dep.Department_ID
left join Visit as v
on d.Doctor_ID = v.Doctor_ID
left join Treatment as t
on v.Visit_ID = t.Visit_ID
left join Billing as b
on v.Visit_ID = b.Visit_ID
group by
d.Doctor_ID,
d.Doctor_Name,
dep.Department_Name;


select *
from vw_doctor_performance;

# 5. Patient demographics
create view vw_patient_demographics as
select
Gender,
Blood_Type,
State,
City,
count(*) as 'Total_Patients',
round(avg(timestampdiff(year, Date_of_Birth, curdate())), 2) as 'Average_Age'
from Patients
group by
Gender,
Blood_Type,
State,
City;

select *
from vw_patient_demographics;

# 6. Insurance analytics
create view vw_insurance_analytics as
select
ip.Provider_Name,
count(distinct pol.Policy_Number) as 'Total_Policies',
count(ic.Claim_ID) as 'Total_Claims',
sum(ic.Amount_Claimed) as 'Claim_Amount',
sum(ic.Approved_Amount) as 'Approved_Amount'
from Insurance_Provider as ip
left join Insurance_Policy as pol
on ip.Provider_ID = pol.Provider_ID
left join Insurance_Claims as ic
on pol.Policy_Number = ic.Policy_Number
group by ip.Provider_Name;

select *
from vw_insurance_analytics;

# 7. Revenue analysis
create view vw_revenue_analysis as
select
Bill_Date,
Payment_Status,
Amount_Billed,
Patient_Paid,
Insurance_Covered,
Outstanding
from Billing;

select *
from vw_revenue_analysis;

# 8. Treatment analytics
create view vw_treatment_analytics as
select
t.Treatment_Name,
dep.Department_Name,
count(*) as 'Total_Treatments',
round(avg(t.Direct_Treatment_Cost), 2) as 'Average_Treatment_Cost'
from Treatment as t
join Visit as v
on t.Visit_ID = v.Visit_ID
join Doctors as d
on v.Doctor_ID = d.Doctor_ID
join Department as dep
on d.Department_ID = dep.Department_ID
group by
t.Treatment_Name,
dep.Department_Name;

select *
from vw_treatment_analytics;