-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_09 : Hospital_Operations_Analytics
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- Department Analysis

# 1. Total visits by department
select
d.Department_Name,
count(v.Visit_ID) as 'Total_Visits'
from Department as d
join Doctors as doc
on d.Department_ID = doc.Department_ID
join Visit as v
on doc.Doctor_ID = v.Doctor_ID
group by d.Department_Name
order by Total_Visits desc;


-- Visit Analysis

# 2. Daily patient visits
select
Visit_Date,
count(*) as 'Total_Visits'
from Visit
group by Visit_Date
order by Visit_Date;


# 3. Monthly patient visits
select
year(Visit_Date) as 'Visit_Year',
month(Visit_Date) as 'Visit_Month',
count(*) as 'Total_Visits'
from Visit
group by year(Visit_Date), month(Visit_Date)
order by year(Visit_Date), month(Visit_Date);


# 4. Visit status distribution
select
Visit_Status,
count(*) as 'Total_Visits'
from Visit
group by Visit_Status
order by Total_Visits desc;


# 5. Average visits handled per doctor
select
round(count(*) / count(distinct Doctor_ID), 2) as 'Avg_Visits_Per_Doctor'
from Visit;


-- Department Workload

# 6. Department workload
select
d.Department_Name,
count(v.Visit_ID) as 'Visits',
count(distinct doc.Doctor_ID) as 'Doctors',
round(count(v.Visit_ID) / count(distinct doc.Doctor_ID), 2) as 'Avg_Visits_Per_Doctor'
from Department as d
join Doctors as doc
on d.Department_ID = doc.Department_ID
left join Visit as v
on doc.Doctor_ID = v.Doctor_ID
group by d.Department_Name
order by Visits desc;


# 7. Visit type distribution
select
Visit_Type,
count(*) as 'Total_Visits'
from Visit
group by Visit_Type
order by Total_Visits desc;


-- Treatment Analysis

# 8. Treatments performed by department
select
d.Department_Name,
count(t.Treatment_ID) as 'Total_Treatments'
from Department as d
join Doctors as doc
on d.Department_ID = doc.Department_ID
join Visit as v
on doc.Doctor_ID = v.Doctor_ID
join Treatment as t
on v.Visit_ID = t.Visit_ID
group by d.Department_Name
order by Total_Treatments desc;


-- Lab Test Analysis

# 9. Lab tests conducted by department
select
d.Department_Name,
count(l.Lab_Result_ID) as 'Total_Lab_Tests'
from Department as d
join Doctors as doc
on d.Department_ID = doc.Department_ID
join Visit as v
on doc.Doctor_ID = v.Doctor_ID
join Lab_Test as l
on v.Visit_ID = l.Visit_ID
group by d.Department_Name
order by Total_Lab_Tests desc;


-- Billing Analysis

# 10. Average bill amount by department
select
d.Department_Name,
round(avg(b.Amount_Billed), 2) as 'Avg_Bill'
from Department as d
join Doctors as doc
on d.Department_ID = doc.Department_ID
join Visit as v
on doc.Doctor_ID = v.Doctor_ID
join Billing as b
on v.Visit_ID = b.Visit_ID
group by d.Department_Name
order by Avg_Bill desc;


# 11. Payment status summary
select
Payment_Status,
count(*) as 'Bills'
from Billing
group by Payment_Status;


# 12. Outstanding amount by department
select
d.Department_Name,
round(sum(b.Outstanding), 2) as 'Outstanding_Amount'
from Department as d
join Doctors as doc
on d.Department_ID = doc.Department_ID
join Visit as v
on doc.Doctor_ID = v.Doctor_ID
join Billing as b
on v.Visit_ID = b.Visit_ID
group by d.Department_Name
order by Outstanding_Amount desc;


-- Diagnosis Analysis

# 13. Most common diagnosis
select
Diagnosis,
count(*) as 'Frequency'
from Visit
group by Diagnosis
order by Frequency desc
limit 10;


-- Performance Summary

# 14. Department performance summary
select
d.Department_Name,
count(distinct doc.Doctor_ID) as 'Doctors',
count(distinct v.Patient_ID) as 'Patients',
count(v.Visit_ID) as 'Visits'
from Department as d
left join Doctors as doc
on d.Department_ID = doc.Department_ID
left join Visit as v
on doc.Doctor_ID = v.Doctor_ID
group by d.Department_Name
order by Visits desc;


-- Hospital Dashboard

# 15. Hospital operations dashboard
select
(select count(*) from Patients) as 'Total_Patients',
(select count(*) from Doctors) as 'Total_Doctors',
(select count(*) from Visit) as 'Total_Visits',
(select count(*) from Treatment) as 'Total_Treatments',
(select count(*) from Lab_Test) as 'Total_Lab_Tests',
(select round(sum(Amount_Billed), 2) from Billing) as 'Total_Revenue';