-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_06 : Patient_Analytics
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- Visit Analysis

# 1. Total visits by each patient
select
p.Patient_ID,
concat(p.First_Name, ' ', p.Last_Name) as 'Patient_Name',
count(v.Visit_ID) as 'Total_Visits'
from Patients as p
left join Visit as v
on p.Patient_ID = v.Patient_ID
group by p.Patient_ID, Patient_Name
order by Total_Visits desc;



# 2. Top 10 frequent patients
select
p.Patient_ID,
concat(p.First_Name, ' ', p.Last_Name) as 'Patient_Name',
count(v.Visit_ID) as 'Visit_Count'
from Patients as p
join Visit as v
on p.Patient_ID = v.Patient_ID
group by p.Patient_ID, Patient_Name
order by Visit_Count desc
limit 10;


-- Age Analysis

# 3. Patients by age
select
Patient_ID,
concat(First_Name, ' ', Last_Name) as 'Patient_Name',
Age
from Patients
order by Age desc;


# 4. Average patient age
select
round(avg(Age),2) as 'Average_Age'
from Patients;


-- Demographic Analysis

# 5. Patients by blood group
select
Blood_Type,
count(*) as 'Total_Patients'
from Patients
group by Blood_Type
order by Total_Patients desc;


# 6. Gender distribution
select
Gender,
count(*) as 'Total'
from Patients
group by Gender;


-- Patient Visit Analysis

# 7. Patients with no visits
select
p.Patient_ID,
concat(p.First_Name, ' ', p.Last_Name) as 'Patient_Name'
from Patients as p
left join Visit as v
on p.Patient_ID = v.Patient_ID
where v.Visit_ID is null;


# 8. Patients having more than 3 visits
select
p.Patient_ID,
concat(p.First_Name, ' ', p.Last_Name) as 'Patient_Name',
count(v.Visit_ID) as 'Total_Visits'
from Patients as p
join Visit as v
on p.Patient_ID = v.Patient_ID
group by p.Patient_ID, Patient_Name
having count(v.Visit_ID) > 3;


-- Registration Analysis

# 9. Patients registered by year
select
year(Registration_Date) as 'Registration_Year',
count(*) as 'Patients'
from Patients
group by Registration_Year
order by Registration_Year;


# 10. State-wise patient count
select
State,
count(*) as 'Patients'
from Patients
group by State
order by Patients desc;


# 11. City-wise patient count
select
City,
count(*) as 'Patients'
from Patients
group by City
order by Patients desc;


-- Insurance Analysis

# 12. Patients with insurance
select
count(*) as 'Insured_Patients'
from Patients
where Policy_Number is not null
and Policy_Number <> '';


# 13. Patients without insurance
select
count(*) as 'Uninsured_Patients'
from Patients
where Policy_Number is null
or Policy_Number = '';


-- Age Extremes

# 14. Oldest patient
select *, age from Patients
order by Age desc
limit 1;


# 15. Youngest patient
select *, age from Patients
order by Age
limit 1;