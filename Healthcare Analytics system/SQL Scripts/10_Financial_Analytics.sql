-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_10 : Financial_Analytics
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- Revenue Overview

# 1. Total revenue
select
sum(Amount_Billed) as 'Total_Revenue'
from Billing;


# 2. Total amount collected
select
sum(Patient_Paid + insurance_Covered) as 'Amount_Collected'
from Billing;


# 3. Total outstanding amount
select
round(sum(Outstanding), 2) as 'Outstanding_Amount'
from Billing;


# 4. Collection percentage
select
round((sum(Patient_Paid + insurance_covered) / sum(Amount_Billed)) * 100, 2) as 'Collection_Percentage'
from Billing;


# 5. Average bill amount
select
round(avg(Amount_Billed), 2) as 'Average_Bill'
from Billing;


# 6. Highest bill
select
max(Amount_Billed) as 'Highest_Bill'
from Billing;


# 7. Lowest bill
select
min(Amount_Billed) as 'Lowest_Bill'
from Billing;


-- Revenue Trends

# 8. Monthly revenue trend
select
year(Bill_Date) as 'Year',
month(Bill_Date) as 'Month',
round(sum(Amount_Billed), 2) as 'Revenue'
from Billing
group by Year, Month
order by Year, Month;



# 10. Revenue by payment status
select
Payment_Status,
count(*) as 'Bills',
round(sum(Amount_Billed), 2) as 'Revenue'
from Billing
group by Payment_Status;


# 11. Top 10 highest bills
select *
from Billing
order by Amount_Billed desc
limit 10;


-- Revenue Analysis

# 12. Revenue by department
select
d.Department_Name,
round(sum(b.Amount_Billed), 2) as 'Revenue'
from Billing as b
join Visit as v
on b.Visit_ID = v.Visit_ID
join Doctors as doc
on v.Doctor_ID = doc.Doctor_ID
join Department as d
on doc.Department_ID = d.Department_ID
group by d.Department_Name
order by Revenue desc;


# 13. Revenue by doctor
select
doc.Doctor_Name,
round(sum(b.Amount_Billed), 2) as 'Revenue'
from Billing as b
join Visit as v
on b.Visit_ID = v.Visit_ID
join Doctors as doc
on v.Doctor_ID = doc.Doctor_ID
group by doc.Doctor_Name
order by Revenue desc;


# 14. Average revenue per patient
select
round(sum(b.Amount_Billed) / count(distinct v.Patient_ID), 2) as 'Avg_Revenue_Per_Patient'
from Billing as b
join Visit as v
on b.Visit_ID = v.Visit_ID;


# 15. Bills with outstanding amount
select *
from Billing
where Outstanding > 0
order by Outstanding desc;


# 16. Revenue by visit type
select
v.Visit_Type,
round(sum(b.Amount_Billed), 2) as 'Revenue'
from Visit as v
join Billing as b
on v.Visit_ID = b.Visit_ID
group by v.Visit_Type
order by Revenue desc;


# 17. Monthly collection vs outstanding
select
year(Bill_Date) as 'Year',
month(Bill_Date) as 'Month',
sum(Patient_Paid) as 'Amount_Collected',
sum(Outstanding) as 'Outstanding'
from Billing
group by Year, Month
order by Year, Month;


-- Financial Dashboard

# 18. Financial dashboard
select
(select round(sum(Amount_Billed), 2) from Billing) as 'Total_Revenue',
(select round(sum(Patient_Paid), 2) from Billing) as 'Amount_Collected',
(select round(sum(Outstanding), 2) from Billing) as 'Outstanding_Amount',
(select round(avg(Amount_Billed), 2) from Billing) as 'Average_Bill',
(select count(*) from Billing) as 'Total_Bills';