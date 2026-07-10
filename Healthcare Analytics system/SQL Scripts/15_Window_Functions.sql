-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_15 : Window_Functions & Advanced_Analytics
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
use HealthcareDB;

-- Window Functions

# 1. Assign row number to patients by registration date
select
Patient_ID,
concat(First_Name, ' ', Last_Name) as 'Patient_Name',
Registration_Date,
row_number() over(order by Registration_Date) as 'Row_Num'
from Patients;


# 2. Rank doctors by revenue
select
d.Doctor_Name,
sum(b.Amount_Billed) as 'Revenue',
rank() over(order by sum(b.Amount_Billed) desc) as 'Revenue_Rank'
from Doctors as d
join Visit as v
on d.Doctor_ID = v.Doctor_ID
join Billing as b
on v.Visit_ID = b.Visit_ID
group by d.Doctor_Name;


# 3. Rank departments by revenue
select
dep.Department_Name,
sum(b.Amount_Billed) as 'Revenue',
dense_rank() over(order by sum(b.Amount_Billed) desc) as 'Department_Rank'
from Department as dep
join Doctors as d
on dep.Department_ID = d.Department_ID
join Visit as v
on d.Doctor_ID = v.Doctor_ID
join Billing as b
on v.Visit_ID = b.Visit_ID
group by dep.Department_Name;


# 4. Divide patients into 4 age groups
select
Patient_ID,
concat(First_Name, ' ', Last_Name) as 'Patient_Name',
timestampdiff(year, Date_of_Birth, curdate()) as 'Age',
ntile(4) over(order by timestampdiff(year, Date_of_Birth, curdate())) as 'Age_Group'
from Patients;


# 5. Previous bill amount
select
Bill_ID,
Bill_Date,
Amount_Billed,
lag(Amount_Billed) over(order by Bill_Date) as 'Previous_Bill'
from Billing;


# 6. Next bill amount
select
Bill_ID,
Bill_Date,
Amount_Billed,
lead(Amount_Billed) over(order by Bill_Date) as 'Next_Bill'
from Billing;


# 7. Running total of revenue
select
Bill_ID,
Bill_Date,
Amount_Billed,
sum(Amount_Billed) over(order by Bill_Date) as 'Running_Revenue'
from Billing;


# 8. Cumulative patients registered
select
Registration_Date,
count(*) as 'Patients_Registered',
sum(count(*)) over(order by Registration_Date) as 'Running_Total'
from Patients
group by Registration_Date;


# 9. Average bill by payment status
select
Bill_ID,
Payment_Status,
Amount_Billed,
round(avg(Amount_Billed) over(partition by Payment_Status), 2) as 'Avg_By_Payment_Status'
from Billing;


# 10. Highest billing doctor in each department
select *
from
(
select
dep.Department_Name,
d.Doctor_Name,
sum(b.Amount_Billed) as 'Revenue',
row_number() over
(
partition by dep.Department_Name
order by sum(b.Amount_Billed) desc
) as rn
from Department as dep
join Doctors as d
on dep.Department_ID = d.Department_ID
join Visit as v
on d.Doctor_ID = v.Doctor_ID
join Billing as b
on v.Visit_ID = b.Visit_ID
group by dep.Department_Name, d.Doctor_Name
) as x
where rn = 1;