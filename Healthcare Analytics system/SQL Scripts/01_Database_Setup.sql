-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROJECT : Healthcare Analytics 
-- AUTHOR  : Pavani Arudra 
-- FILE_01    : Database_Setup
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# Creating Database
create database HealthcareDB;
use HealthcareDB;

# Creating Department Table

Create table Department (Department_ID int primary key,
                         Department_Name Varchar(100) Not null,
                         Speciality_Covered Varchar(100),
                         Location Varchar(100),
                         Department_Type Varchar(100));


# Creating Doctors Table

Create table Doctors (Doctor_ID int Primary key,
					  Doctor_Name varchar(100) not null,
                      Gender Varchar(10),
                      Speciality Varchar(100),
                      Department_ID int,
                      Years_Of_Experince int,
                      Hospital_Affiliation varchar(100),
                      Clinic_Name varchar(100),
                      Phone_Number varchar(20),
                      Email varchar(100),
                      License_Number varchar(50),
                      Is_Active varchar(5),
                      Constraint FK_Doctor_Department
                      foreign key (department_id)
                      references Department(Department_ID));

select * from doctors;
delete from doctors;

# Creating Patients table

Create table Patients (Patient_ID int primary key,
                       First_Name varchar(50),
                       Last_Name varchar(50),
                       Gender varchar(10),
                       Date_Of_Birth date,
                       Age int,
                       Blood_type varchar(5),
                       Phone_Number varchar(50),
                       Alternate_Phone_Number varchar(50),
                       Address varchar(255),
                       State varchar(50),
                       City varchar(50),
                       Country varchar(50),
                       Insurance_Provider varchar(50),
                       Policy_Number varchar(50),
                       Marital_status varchar(20),
                       Race varchar(20),
                       Ethnicity varchar(20),
                       Chronic_Conditions varchar(50),
                       Allergies varchar(20),
                       Medical_History varchar(20),
                       Patinet_Status varchar(20),
                       Registration_Date date,
                       Emergency_Contact_Phone varchar(50));


# Creating Visit table

Create table Visit (Visit_ID int Primary key,
                    Patient_ID int not null,
                    Doctor_ID int not null,
                    Visit_date date,
                    Visit_Year Year,
                    Visit_Month int,
                    Visit_Month_Name varchar(20),
                    Visit_Quarter int,
                    Visit_Type varchar(50),
                    Visit_status varchar(50),
                    Diagnosis varchar(50),
                    Diagnosis_Code varchar(20),
                    Reason_For_Visit varchar(50),
                    Follow_Up_Required varchar(10),
                    Prescribed_Medicines varchar(50),
                    Visit_Duration int,
                    foreign key (Patient_Id) references patients(patient_id),
                    foreign key (Doctor_ID) references doctors(doctor_id));

# Creating Treatment Table

Create table Treatment (Treatment_ID int primary key,
                        Visit_ID int not null,
                        Treatment_Type varchar(50),
                        Treatment_Name varchar(50),
                        Medication_Prescribed varchar(50),
                        Dosage varchar(10),
                        Instructions varchar(50),
                        Treatment_Start_Date date,
                        Treatment_End_Date date,
                        Duration_Days int,
                        Status varchar(20),
                        Outcome varchar(20),
                        Direct_Treatment_Cost int,
                        Total_Episode_Cost int,
                        Treatment_Description varchar(50),
                        foreign key (Visit_ID) references visit(visit_id));

# Creating Billing Table

create table Billing (Bill_ID int primary key,
                      Visit_ID int,
                      Patient_ID int,
                      Amount_Billed int,
                      Insurance_Covered int,
                      Patient_Paid int,
                      Outstanding int,
                      Payment_status varchar(50),
                      Bill_Date date,
                      Payment_Date date,
                      Payment_Date_Display varchar(25),
                      foreign key (Visit_ID) references visit(visit_id),
                      foreign key (Patient_ID) references patients(patient_id));

# Creating Insurance_Provider Table

create table Insurance_Provider (Provider_ID varchar(10) primary key,
                                 Provider_Name varchar(50),
                                 Ticker_Symbol varchar(10),
								 Primary_Plan_Type varchar(10),
								 Network_Scope varchar(20),
                                 Member_Satisfaction decimal(2,1),
                                 Customer_Service_Phone varchar(20),
                                 Financial_Rating varchar(10));


# Creating Insurance_Policy Table

create table Insurance_Policy (Policy_Number varchar(20) primary key,
                               Patient_ID int,
                               Provider_ID varchar(25),
                               Provider_Name varchar(50),
                               Plan_Type varchar(15),
                               Coverage_Tier varchar(20),
                               Monthly_Premium int,
                               Annual_Deductible int,
                               Copay int,
                               Out_of_Pocket int,
                               Coinsurance int,
                               Coverage_Start_Date date,
                               Coverage_End_Date date,
                               Policy_Status varchar(10),
                               Rx_Coverage varchar(5),
                               Mental_Health_Coverage varchar(5),
                               Dental_Rider varchar(5),
                               Vision_Rider varchar(5),
                               Foreign key (Patient_ID) references patients(patient_id),
                               foreign key (provider_id) references insurance_provider(provider_id));
                               

# creating table Insurance_Claims

Create table Insurance_claims (Claim_ID varchar(20) primary key,
                               Bill_ID int,
                               Visit_ID int,
                               Patient_ID int,
                               Policy_Number varchar(50),
                               Provider_ID varchar(20),
                               Provider_Name varchar(50),
                               Plan_Type varchar(10),
                               Claim_Type varchar(20),
                               Claim_Date date,
                               Amount_Billed int,
                               Amount_Claimed int,
                               Approved_Amount int,
                               Patient_Responsibility int,
                               Outstanding int,
                               Claim_status varchar(20),
                               Denial_Reason varchar(50),
                               Processing_Days int,
                               Appeal_Status varchar(50),
                               Submitted_Electronically varchar(10),
                               Network_Status varchar(20),
                               Foreign key (Bill_ID) references Billing(Bill_id),
                               foreign key (visit_id) references visit(visit_id),
                               Foreign key (Patient_ID) references patients(patient_id),
                               Foreign key (Policy_Number) references insurance_policy(policy_number),
                               foreign key (provider_id) references insurance_provider(provider_id));

# Creating Table Lab_Test

create table Lab_Test (Lab_Result_ID int primary key,
                       Visit_ID int,
                       Doctor_ID int,
                       Test_Name varchar(20),
                       Test_Date date,
                       Test_Year year,
                       Test_Month int,
                       Test_Month_Name varchar(20),
                       Test_Result varchar(20),
                       Numeric_Test_Result int,
                       Units varchar(20),
                       Reference_Range varchar(20),
                       Comments varchar(80),
                       foreign key (visit_id) references visit(visit_id),
                       foreign key (doctor_id) references doctors(doctor_id));


# Showing tables

show tables;

# Describing Tables

Describe Department;
Describe patients;
Describe doctors;
Describe Visit;
Describe Lab_Test;
Describe Insurance_policy;
Describe Insurance_Provider;
Describe Insurance_claims;
Describe Billing;
Describe Treatment;

