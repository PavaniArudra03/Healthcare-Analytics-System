-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_02 : Data_Import
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- NOTE:
-- Data was imported using MySQL Workbench's
-- "Table Data Import Wizard".
-- This script verifies that the import was successful.

# 1. Verify record count in each table

select 'Department' as Table_Name, count(*) as 'Total_Records'
from Department
union all
select 'Doctor' as Table_Name, count(*) as 'Total_Records'
from Doctors
union all
select 'Patient' as Table_Name, count(*) as 'Total_Records'
from Patients
union all
select 'Visit' as Table_Name, count(*) as 'Total_Records'
from Visit
union all
select 'Treatment' as Table_Name, count(*) as 'Total_Records'
from Treatment
union all
select 'Billing' as Table_Name, count(*) as 'Total_Records'
from Billing
union all
select 'Insurance_Provider' as Table_Name, count(*) as 'Total_Records'
from Insurance_Provider
union all
select 'Insurance_Policy' as Table_Name, count(*) as 'Total_Records'
from Insurance_Policy
union all
select 'Insurance_Claims' as Table_Name, count(*) as 'Total_Records'
from Insurance_Claims
union all
select 'Lab_Test' as Table_Name, count(*) as 'Total_Records'
from Lab_Test;

# 2. Preview Patient data
select * from patients limit 10;

# 3. Preview Department data
select * from Department limit 10;

# 4. Preview Doctor data
select * from Doctors limit 10;

# 5. Preview Visit data
select * from Visit limit 10;

# 6. Preview Treatment data
select * from Treatment limit 10;

# 7. Preview Billing data
select * from Billing limit 10;

# 8. Preview Insurance Provider data
select * from Insurance_Provider limit 10;

# 9. Preview Insurance Policy data
select * from Insurance_Policy limit 10;

# 10. Preview Insurance Claims data
select * from Insurance_Claims limit 10;

# 11. Preview Lab Test data
select * from Lab_Test limit 10;


# 12. Verify import completed successfully
select 'Data Import Verification Completed Successfully' as status;
