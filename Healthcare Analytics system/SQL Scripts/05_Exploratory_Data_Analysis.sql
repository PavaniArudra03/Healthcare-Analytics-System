-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_05 : Exploratory_Data_Analysis
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- Basic Statistics

# 1. Total patients
select count(*) as 'Total_Patients'
from Patients;


# 2. Total doctors
select count(*) as 'Total_Doctors'
from Doctors;

# 3. Total visits
select count(*) as 'Total_Visits'
from Visit;

# 4. Total treatments
select count(*) as 'Total_Treatments'
from Treatment;

# 5. Total bills
select count(*) as 'Total_Bills'
from Billing;

# 6. Total insurance claims
select count(*) as 'Total_Claims'
from Insurance_Claims;


-- Patient Demographics

# 7. Gender distribution
select Gender, count(*) as 'Patients'
from Patients
group by Gender;

# 8. Blood group distribution
select Blood_Type, count(*) as 'Total'
from Patients
group by Blood_Type
order by Total desc;

# 9. Patients by state
select State, count(*) as 'Patients'
from Patients
group by State
order by Patients desc;

# 10. Patients by city
select City, count(*) as 'Patients'
from Patients
group by City
order by Patients desc;


-- Doctor & Department Analysis

# 11. Doctors by department
select
    d.Department_Name,
    count(doc.Doctor_ID) as 'Doctors'
from Department as d
left join Doctors as doc
on d.Department_ID = doc.Department_ID
group by d.Department_Name;


-- Visit Analysis

# 12. Visit type distribution
select Visit_Type, count(*) as 'Visits'
from Visit
group by Visit_Type;

# 13. Visit status distribution
select Visit_Status, count(*) as 'Visits'
from Visit
group by Visit_Status;

# 14. Most common diagnoses
select Diagnosis, count(*) as 'Frequency'
from Visit
group by Diagnosis
order by Frequency desc
limit 10;


-- Treatment & Billing Analysis


# 15. Average treatment cost
select round(avg(Direct_Treatment_Cost), 2) as 'Avg_Treatment_Cost'
from Treatment;

# 16. Highest bill amount
select max(Amount_Billed) as 'Highest_Bill'
from Billing;

# 17. Payment_Status Distribution
select payment_status, count(*) as 'Bills' 
from billing group by payment_status;

-- Insurance Analysis

# 18. Insurance claim status
select Claim_Status, count(*) as 'Claims'
from Insurance_Claims
group by Claim_Status;


-- Laboratory Analysis

# 19. Most requested lab tests
select Test_Name, count(*) as 'Total_Tests'
from Lab_Test
group by Test_Name
order by Total_Tests desc;


-- Registration Trend

# 20. Patient registration trend
select
    year(Registration_Date) as 'Year',
    count(*) as 'New_Patients'
from Patients
group by year(Registration_Date)
order by year;