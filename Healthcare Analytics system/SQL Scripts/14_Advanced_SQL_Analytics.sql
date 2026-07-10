-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_14 : Advanced_SQL_Analytics using CTEs, Subqueries, CASE, EXISTS & UNION
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- Advanced SQL Analysis

# 1. Top 5 patients by number of visits
with PatientVisits as (
select
Patient_ID,
count(*) as 'Total_Visits'
from Visit
group by Patient_ID
)
select *
from PatientVisits
order by Total_Visits desc
limit 5;


# 2. Revenue by department
with DeptRevenue as (
select
d.Department_Name,
sum(b.Amount_Billed) as 'Revenue'
from Department as d
join Doctors as doc
on d.Department_ID = doc.Department_ID
join Visit as v
on doc.Doctor_ID = v.Doctor_ID
join Billing as b
on v.Visit_ID = b.Visit_ID
group by d.Department_Name
)
select *
from DeptRevenue
order by Revenue desc;


# 3. Bills above average amount
select *
from Billing
where Amount_Billed >
(
select avg(Amount_Billed)
from Billing
);


# 4. Doctors generating above average revenue
select
doc.Doctor_Name,
sum(b.Amount_Billed) as 'Revenue'
from Doctors as doc
join Visit as v
on doc.Doctor_ID = v.Doctor_ID
join Billing as b
on v.Visit_ID = b.Visit_ID
group by doc.Doctor_Name
having Revenue >
(
select avg(Amount_Billed)
from Billing
);


# 5. Categorize bills using CASE
select
Bill_ID,
Amount_Billed,
case
    when Amount_Billed >= 10000 then 'High'
    when Amount_Billed >= 5000 then 'Medium'
    else 'Low'
end as 'Bill_Category'
from Billing;


# 6. Patients with at least one visit (EXISTS)
select *
from Patients as p
where exists
(
select 1
from Visit as v
where v.Patient_ID = p.Patient_ID
);


# 7. Patients without any visit (NOT EXISTS)
select *
from Patients as p
where not exists
(
select 1
from Visit as v
where v.Patient_ID = p.Patient_ID
);


# 8. Bills above average within the same payment status
select *
from Billing as b
where Amount_Billed >
(
select avg(Amount_Billed)
from Billing
where Payment_Status = b.Payment_Status
);


# 9. Department with highest revenue
select
Department_Name,
Revenue
from
(
select
d.Department_Name,
sum(b.Amount_Billed) as 'Revenue'
from Department as d
join Doctors as doc
on d.Department_ID = doc.Department_ID
join Visit as v
on doc.Doctor_ID = v.Doctor_ID
join Billing as b
on v.Visit_ID = b.Visit_ID
group by d.Department_Name
) as x
where Revenue =
(
select max(Revenue)
from
(
select
sum(b.Amount_Billed) as 'Revenue'
from Department as d
join Doctors as doc
on d.Department_ID = doc.Department_ID
join Visit as v
on doc.Doctor_ID = v.Doctor_ID
join Billing as b
on v.Visit_ID = b.Visit_ID
group by d.Department_Name
) as y
);


# 10. UNION of patients and doctors
select
concat(First_Name, ' ', Last_Name) as 'Name',
'Patient' as 'Person_Type'
from Patients
union
select
Doctor_Name,
'Doctor'
from Doctors;


# 11. Treatments costing above department average
select
t.*
from Treatment as t
join Visit as v
on t.Visit_ID = v.Visit_ID
join Doctors as d
on v.Doctor_ID = d.Doctor_ID
where t.Direct_Treatment_Cost >
(
select avg(t2.Direct_Treatment_Cost)
from Treatment as t2
join Visit as v2
on t2.Visit_ID = v2.Visit_ID
join Doctors as d2
on v2.Doctor_ID = d2.Doctor_ID
where d2.Department_ID = d.Department_ID
);


# 12. Insurance claim category using CASE
select
Claim_ID,
Claim_Status,
case
    when Claim_Status = 'Approved' then 'Completed'
    when Claim_Status = 'Pending' then 'In Progress'
    else 'Rejected'
end as 'Claim_Category'
from Insurance_Claims;


# 13. Doctors treating insured patients
select distinct
d.Doctor_Name
from Doctors as d
join Visit as v
on d.Doctor_ID = v.Doctor_ID
join Patients as p
on v.Patient_ID = p.Patient_ID
where p.Policy_Number is not null
and p.Policy_Number <> '';


# 14. Patient with the highest bill
select
p.Patient_ID,
concat(p.First_Name, ' ', p.Last_Name) as 'Patient_Name',
b.Amount_Billed
from Patients as p
join Visit as v
on p.Patient_ID = v.Patient_ID
join Billing as b
on v.Visit_ID = b.Visit_ID
order by b.Amount_Billed desc
limit 1;


# 15. Advanced dashboard
select
(select count(*) from Patients) as 'Patients',
(select count(*) from Visit) as 'Visits',
(select sum(Amount_Billed) from Billing) as 'Revenue',
(select count(*) from Insurance_Claims) as 'Claims';