-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_16 : Query Performance Optimization
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- Query Optimization & Indexing

# 1. Analyze execution plan for patient lookup
explain
select *
from Patients
where Patient_ID = 101;


# 2. Create index on Visit.Patient_ID
create index idx_visit_patient
on Visit(Patient_ID);


# 3. Create index on Visit.Doctor_ID
create index idx_visit_doctor
on Visit(Doctor_ID);


# 4. Create index on Billing.Bill_Date
create index idx_billing_bill_date
on Billing(Bill_Date);


# 5. Verify optimized query using index
explain
select *
from Visit
where Patient_ID = 101;


# 6. Analyze revenue query execution plan
explain
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
group by d.Department_Name;