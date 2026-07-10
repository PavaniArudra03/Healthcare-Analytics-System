-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_12 : Treatment_Analytics
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
use HealthcareDB;

-- Treatment Overview

# 1. Total treatments performed
select
count(*) as 'Total_Treatments'
from Treatment;


# 2. Most common treatments
select
Treatment_Name,
count(*) as 'Total_Performed'
from Treatment
group by Treatment_Name
order by Total_Performed desc;


# 3. Average treatment cost
select
round(avg(Direct_Treatment_Cost), 2) as 'Average_Treatment_Cost'
from Treatment;


# 4. Most expensive treatments
select *
from Treatment
order by Direct_Treatment_Cost desc
limit 10;


# 5. Least expensive treatments
select *
from Treatment
order by Direct_Treatment_Cost
limit 10;


-- Doctor Analysis

# 6. Treatments performed by each doctor
select
d.Doctor_Name,
count(t.Treatment_ID) as 'Total_Treatments'
from Doctors as d
join Visit as v
on d.Doctor_ID = v.Doctor_ID
join Treatment as t
on v.Visit_ID = t.Visit_ID
group by d.Doctor_Name
order by Total_Treatments desc;


-- Department Analysis

# 7. Treatments by department
select
dep.Department_Name,
count(t.Treatment_ID) as 'Total_Treatments'
from Department as dep
join Doctors as d
on dep.Department_ID = d.Department_ID
join Visit as v
on d.Doctor_ID = v.Doctor_ID
join Treatment as t
on v.Visit_ID = t.Visit_ID
group by dep.Department_Name
order by Total_Treatments desc;


# 8. Treatment cost by department
select
dep.Department_Name,
round(sum(t.Direct_Treatment_Cost), 2) as 'Total_Cost'
from Department as dep
join Doctors as d
on dep.Department_ID = d.Department_ID
join Visit as v
on d.Doctor_ID = v.Doctor_ID
join Treatment as t
on v.Visit_ID = t.Visit_ID
group by dep.Department_Name
order by Total_Cost desc;


-- Cost Analysis

# 9. Average treatment cost by doctor
select
d.Doctor_Name,
round(avg(t.Direct_Treatment_Cost), 2) as 'Avg_Treatment_Cost'
from Doctors as d
join Visit as v
on d.Doctor_ID = v.Doctor_ID
join Treatment as t
on v.Visit_ID = t.Visit_ID
group by d.Doctor_Name
order by Avg_Treatment_Cost desc;


# 10. Monthly treatment trend
select
year(Treatment_Start_Date) as 'Treatment_Year',
month(Treatment_Start_Date) as 'Treatment_Month',
count(*) as 'Total_Treatments'
from Treatment
group by year(Treatment_Start_Date), month(Treatment_Start_Date)
order by year(Treatment_Start_Date), month(Treatment_Start_Date);

-- Treatment Dashboard

# 11. Treatment dashboard
select
(select count(*) from Treatment) as 'Total_Treatments',
(select round(avg(Direct_Treatment_Cost), 2) from Treatment) as 'Average_Cost',
(select round(sum(Direct_Treatment_Cost), 2) from Treatment) as 'Total_Treatment_Cost';