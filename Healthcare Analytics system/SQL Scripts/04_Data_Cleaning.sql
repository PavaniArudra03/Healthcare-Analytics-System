-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_04 : Data_Cleaning
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- handling Duplicates

# 1. Check for duplicate departments
select Department_ID, count(*) as 'Duplicate_Count'
from Department
group by Department_ID
having count(*) > 1;


# 2. Check for duplicate doctors
select Doctor_ID, count(*) as 'Duplicate_Count'
from Doctors
group by Doctor_ID
having count(*) > 1;


# 3. Check for duplicate patients
select Patient_ID, count(*) as 'Duplicate_Count'
from Patients
group by Patient_ID
having count(*) > 1;


# 4. Check for duplicate visits
select Visit_ID, count(*) as 'Duplicate_Count'
from Visit
group by Visit_ID
having count(*) > 1;


# 5. Check for duplicate treatments
select Treatment_ID, count(*) as 'Duplicate_Count'
from Treatment
group by Treatment_ID
having count(*) > 1;


# 6. Check for duplicate bills
select Bill_ID, count(*) as 'Duplicate_Count'
from Billing
group by Bill_ID
having count(*) > 1;


# 7. Check for duplicate insurance providers
select Provider_ID, count(*) as 'Duplicate_Count'
from Insurance_Provider
group by Provider_ID
having count(*) > 1;


# 8. Check for duplicate insurance policies
select Policy_Number, count(*) as 'Duplicate_Count'
from Insurance_Policy
group by Policy_Number
having count(*) > 1;


# 9. Check for duplicate insurance claims
select Claim_ID, count(*) as 'Duplicate_Count'
from Insurance_Claims
group by Claim_ID
having count(*) > 1;


# 10. Check for duplicate lab tests
select Lab_Result_ID, count(*) as 'Duplicate_Count'
from Lab_Test
group by Lab_Result_ID
having count(*) > 1;

-- Handling NULL Values

 # 11. Find patients with NULL first name
select *
from Patients
where First_Name is null;

# 12. Find patients with NULL last name
select *
from Patients
where Last_Name is null;

# 13. Find missing phone numbers
select *
from Patients
where Phone is null or Phone = '';

# 14. Find Patinets with No Insurance
select *
from Patients
where Policy_Number is null or Policy_Number = '';


-- Data Validation

# 15. Check distinct gender values in Patient
select distinct Gender
from Patients;

# 16. Check distinct gender values in Doctor
select distinct Gender
from Doctors;

# 17. Find patients without insurance policy
select p.*
from Patients as p
left join Insurance_Policy as ip
on p.Patient_ID = ip.Patient_ID
where ip.Policy_Number is null;

# 18. Bills where paid amount exceeds total amount
select *
from Billing
where Patient_Paid > Amount_Billed;

# 19. Negative treatment cost
select *
from Treatment
where Direct_Treatment_Cost < 0;


# 20. Visits without diagnosis
select *
from Visit
where Diagnosis is null or Diagnosis = '';

# 21. Future visit dates
select *
from Visit
where Visit_Date > curdate();

# 22. Patients with invalid date of birth
select *
from Patients
where Date_of_Birth > curdate();

# 23. Expired insurance policies
select *
from Insurance_Policy
where Coverage_End_Date < curdate();

# 24. Patients older than 120 years
select *
from Patients
where timestampdiff(year, Date_of_Birth, curdate()) > 120;

# 25. Invalid insurance coverage dates
select *
from Insurance_Policy
where Coverage_Start_Date > Coverage_End_Date;

# 26. Summary of missing values

select
    sum(case when First_Name is null or First_Name = '' then 1 else 0 end) as 'Missing_First_Name',
    sum(case when Last_Name is null or Last_Name = '' then 1 else 0 end) as 'Missing_Last_Name',
    sum(case when Phone_Number is null or Phone_Number = '' then 1 else 0 end) as 'Missing_Phone',
    sum(case when Policy_Number is null or Policy_Number = '' then 1 else 0 end) as 'Missing_Insurance'
from Patients;


