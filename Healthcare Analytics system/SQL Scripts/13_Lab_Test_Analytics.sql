-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_13 : Lab_Test_Analytics
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- Lab Test Overview

# 1. Total lab tests conducted
select
count(*) as 'Total_Lab_Tests'
from Lab_Test;


# 2. Most frequently performed lab tests
select
Test_Name,
count(*) as 'Total_Tests'
from Lab_Test
group by Test_Name
order by Total_Tests desc;


# 3. Average lab test result
select Test_Name,
round(avg(Numeric_Test_Result), 2) as 'Average_Test_Result'
from Lab_Test group by Test_Name;


# 4. Most expensive lab tests
select *
from Lab_Test
order by Test_Cost desc
limit 10;


-- Department Analysis

# 6. Lab tests by department
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


-- Doctor Analysis

# 7. Lab tests ordered by doctor
select
doc.Doctor_Name,
count(l.Lab_Result_ID) as 'Total_Lab_Tests'
from Doctors as doc
join Visit as v
on doc.Doctor_ID = v.Doctor_ID
join Lab_Test as l
on v.Visit_ID = l.Visit_ID
group by doc.Doctor_Name
order by Total_Lab_Tests desc;


-- Trend Analysis

# 8. Monthly lab test trend
select
year(Test_Date) as 'Test_Year',
month(Test_Date) as 'Test_Month',
count(*) as 'Total_Tests'
from Lab_Test
group by year(Test_Date), month(Test_Date)
order by year(Test_Date), month(Test_Date);


-- Result Analysis

# 9. Lab test result distribution
select
Test_Result,
count(*) as 'Total_Results'
from Lab_Test
group by Test_Result
order by Total_Results desc;


-- Lab Dashboard

# 10. Lab analytics dashboard
select
(select count(*) from Lab_Test) as 'Total_Lab_Tests',
(select count(distinct Test_Name) from Lab_Test) as 'Unique_Test_Types',
(select count(distinct Doctor_ID) from Lab_Test) as 'Doctors_Ordering_Tests',
(select count(distinct Visit_ID) from Lab_Test) as 'Visits_With_Lab_Tests';