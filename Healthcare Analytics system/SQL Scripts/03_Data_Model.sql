-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_03 : Data_Model
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Use HealthcareDB;

# 1. Verify Department - Doctor Relationship
Select
    d.Department_ID,
    d.Department_Name,
    COUNT(doc.Doctor_ID) as 'Total_Doctors'
From Department  as d
Left join Doctors as doc
on  d.Department_ID = doc.Department_ID
Group by d.Department_ID, d.Department_Name;

# 2. Verify Patient - Visit Relationship
Select
    p.Patient_ID,
    CONCAT(p.First_Name,' ',p.Last_Name) as 'Patient_Name',
    COUNT(v.Visit_ID) as 'Total_Visits'
from Patients as p
left join Visit v
on p.Patient_ID = v.Patient_ID
group by p.Patient_ID, Patient_Name;


# 3. Verify Doctor - Visit Relationship
select
    d.Doctor_ID,
    d.Doctor_Name,
    count(v.Visit_ID) as 'Total_Visits'
from Doctors as d
left join Visit as v
on d.Doctor_ID = v.Doctor_ID
group by d.Doctor_ID, d.Doctor_Name;


# 4. Verify Visit - Treatment Relationship
select
    v.Visit_ID,
    count(t.Treatment_ID) as 'Total_Treatments'
from Visit as v
left join Treatment as t
on v.Visit_ID = t.Visit_ID
group by v.Visit_ID;


# 5. Verify Visit - Billing Relationship
select
    v.Visit_ID,
    count(b.Bill_ID) as 'Total_Bills'
from Visit as v
left join Billing as b
on v.Visit_ID = b.Visit_ID
group by v.Visit_ID;


# 6. Verify Patient - Insurance Policy Relationship
select
    p.Patient_ID,
    concat(p.First_Name,' ',p.Last_Name) as 'Patient_Name',
    ip.Policy_Number,
    pr.Provider_Name
from Patients as p
left join Insurance_Policy as ip
on p.Patient_ID = ip.Patient_ID
left join Insurance_Provider as pr
on ip.Provider_ID = pr.Provider_ID;


# 7. Verify Insurance Policy - Insurance Claims Relationship
select
    ip.Policy_Number,
    count(ic.Claim_ID) as 'Total_Claims'
from Insurance_Policy as ip
left join Insurance_Claims as ic
on ip.Policy_Number = ic.Policy_Number
group by ip.Policy_Number;


# 8. Verify Visit - Lab Test Relationship
select
    v.Visit_ID,
    count(lt.Lab_Result_ID) as 'Total_Lab_Tests'
from Visit as v
left join Lab_Test as lt
on v.Visit_ID = lt.Visit_ID
group by v.Visit_ID;


# 9. Verify Billing - Insurance Claims Relationship
select
    b.Bill_ID,
    count(ic.Claim_ID) as 'Total_Claims'
from Billing as b
left join Insurance_Claims as ic
on b.Bill_ID = ic.Bill_ID
group by b.Bill_ID;


# 10. Data Model Summary
select
    (select count(*) from Department) as 'Departments',
    (select count(*) from Doctors) as 'Doctors',
    (select count(*) from Patients) as 'Patients',
    (select count(*) from Visit) as 'Visits',
    (select count(*) from Treatment) as 'Treatments',
    (select count(*) from Billing) as 'Bills',
    (select count(*) from Insurance_Provider) as 'Providers',
    (select count(*) from Insurance_Policy) as 'Policies',
    (select count(*) from Insurance_Claims) as 'Claims',
    (select count(*) from Lab_Test) as 'Lab_Tests';
    
    
    
    
    
    
