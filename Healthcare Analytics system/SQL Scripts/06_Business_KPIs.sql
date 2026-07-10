-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_06 : Business_KPIs
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- Revenue Analysis

# 1. Total revenue
select sum(Amount_Billed) as 'Total_Revenue'
from Billing;

# 2. Total amount collected
select sum(Patient_Paid) as 'Total_Collected'
from Billing;

# 3. Total outstanding amount
select sum(Outstanding) as 'Outstanding_Amount'
from Billing;

# 4. Average bill value
select round(avg(Amount_Billed), 2) as 'Average_Bill'
from Billing;


-- Hospital Statistics

# 5. Total patients
select count(*) as 'Total_Patients'
from Patients;

# 6. Total doctors
select count(*) as 'Total_Doctors'
from Doctors;

# 7. Total visits
select count(*) as 'Total_Visits'
from Visit;


-- Revenue KPIs

# 8. Average revenue per visit
select round(sum(Amount_Billed) / count(*), 2) as 'Avg_Revenue_Per_Visit'
from Billing;

# 9. Average revenue per patient
select
    round(sum(b.Amount_Billed) / count(distinct v.Patient_ID), 2) as 'Avg_Revenue_Per_Patient'
from Billing as b
join Visit as v
on b.Visit_ID = v.Visit_ID;


-- Department & Doctor Performance

# 10. Top 5 departments by number of visits
select
    d.Department_Name,
    count(v.Visit_ID) as 'Total_Visits'
from Visit as v
join Doctors as doc
on v.Doctor_ID = doc.Doctor_ID
join Department as d
on doc.Department_ID = d.Department_ID
group by d.Department_Name
order by Total_Visits desc
limit 5;

# 11. Top 5 doctors by patient visits
select
    doc.Doctor_Name,
    count(v.Visit_ID) as 'Total_Visits'
from Doctors as doc
join Visit as v
on doc.Doctor_ID = v.Doctor_ID
group by doc.Doctor_Name
order by Total_Visits desc
limit 5;


-- Billing Analysis

# 12. Payment status summary
select
    Payment_Status,
    count(*) as 'Bills',
    sum(Amount_Billed) as 'Revenue'
from Billing
group by Payment_Status;


-- Insurance Analysis

# 13. Insurance claim approval rate
select
    round(sum(case when Claim_Status = 'Approved' then 1 else 0 end) * 100.0 /
        count(*),2) as 'Approval_Rate_Percentage'
from Insurance_Claims;


-- Treatment Analysis

# 14. Average treatment cost
select
    round(avg(Direct_Treatment_Cost), 2) as 'Avg_Treatment_Cost'
from Treatment;


-- Executive KPI Dashboard

# 15. Executive KPI dashboard
select
    (select count(*) from Patients) as 'Total_Patients',
    (select count(*) from Doctors) as 'Total_Doctors',
    (select count(*) from Visit) as 'Total_Visits',
    (select sum(Amount_Billed) from Billing) as 'Total_Revenue',
    (select sum(Patient_Paid) from Billing) as 'Amount_Collected',
    (select sum(Outstanding) from Billing) as 'Outstanding_Amount';