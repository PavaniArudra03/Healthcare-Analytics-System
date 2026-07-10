-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_11 : Insurance Policies, Providers & Claims Analytics
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use HealthcareDB;

-- Insurance Overview

# 1. Total insurance providers
select
count(*) as 'Total_Providers'
from Insurance_Provider;


# 2. Total insurance policies
select
count(*) as 'Total_Policies'
from Insurance_Policy;


# 3. Total insurance claims
select
count(*) as 'Total_Claims'
from Insurance_Claims;


-- Provider Analysis

# 4. Patients covered by each provider
select
ip.Provider_Name,
count(distinct pol.Patient_ID) as 'Covered_Patients'
from Insurance_Provider as ip
left join Insurance_Policy as pol
on ip.Provider_ID = pol.Provider_ID
group by ip.Provider_Name
order by Covered_Patients desc;


# 5. Policies by type
select
Plan_Type,
count(*) as 'Total_Policies'
from Insurance_Policy
group by Plan_Type
order by Total_Policies desc;


# 6. Total claim amount by provider
select
ip.Provider_Name,
round(sum(ic.Amount_Claimed), 2) as 'Total_Claim_Amount'
from Insurance_Provider as ip
join Insurance_Policy as pol
on ip.Provider_ID = pol.Provider_ID
join Insurance_Claims as ic
on pol.Policy_Number = ic.Policy_Number
group by ip.Provider_Name
order by Total_Claim_Amount desc;


# 7. Approved amount by provider
select
ip.Provider_Name,
round(sum(ic.Approved_Amount), 2) as 'Approved_Amount'
from Insurance_Provider as ip
join Insurance_Policy as pol
on ip.Provider_ID = pol.Provider_ID
join Insurance_Claims as ic
on pol.Policy_Number = ic.Policy_Number
group by ip.Provider_Name
order by Approved_Amount desc;


-- Claims Analysis

# 8. Claim status distribution
select
Claim_Status,
count(*) as 'Total_Claims'
from Insurance_Claims
group by Claim_Status;


# 9. Claim approval percentage
select
round(
sum(case when Claim_Status = 'Approved' then 1 else 0 end)
* 100.0 / count(*), 2
) as 'Approval_Rate'
from Insurance_Claims;


# 10. Top 10 highest claims
select *
from Insurance_Claims
order by Amount_Claimed desc
limit 10;


# 11. Average claim amount
select
round(avg(Amount_Claimed), 2) as 'Average_Claim_Amount'
from Insurance_Claims;


-- Policy Analysis

# 12. Active vs expired policies
select
case
    when Coverage_End_Date >= curdate() then 'Active'
    else 'Expired'
end as 'Policy_Status',
count(*) as 'Total_Policies'
from Insurance_Policy
group by
case
    when Coverage_End_Date >= curdate() then 'Active'
    else 'Expired'
end;


# 13. Patients without insurance
select
Patient_ID,
concat(First_Name, ' ', Last_Name) as 'Patient_Name'
from Patients
where Policy_Number is null
or Policy_Number = '';


# 14. Claims linked to unpaid bills
select
ic.Claim_ID,
b.Bill_ID,
b.Payment_Status,
ic.Claim_Status
from Insurance_Claims as ic
join Billing as b
on ic.Bill_ID = b.Bill_ID
where b.Payment_Status <> 'Paid';


-- Insurance Dashboard

# 15. Insurance dashboard
select
(select count(*) from Insurance_Provider) as 'Providers',
(select count(*) from Insurance_Policy) as 'Policies',
(select count(*) from Insurance_Claims) as 'Claims',
(select round(sum(Amount_Claimed), 2) from Insurance_Claims) as 'Total_Claim_Amount',
(select round(sum(Approved_Amount), 2) from Insurance_Claims) as 'Total_Approved_Amount';