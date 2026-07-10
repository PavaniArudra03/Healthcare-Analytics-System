#_FUNCTIONS_#
-- (SUM, AVG, COUNT, MIN, MAX, CURDATE, NOW, DATEDIFF, DATE_ADD, DATE_SUB, YEAR, MONTH, UPPER, LOWER, CONCAT, LENGTH, SUBSTRING, TRIM, REPLACE, GROUP BY, HAVING)

use classicmodels;

# 1.	Display employee names in uppercase.
select upper(employee_name) as 'Employee_Name' from employees;

# 2.	Retrieve orders placed in the last 30 days.
select * from orders where order_date between date_sub(curdate(), interval 30 day) and curdate();

# 3.	Find departments where average salary is greater than 50,000.
select dep_name, avg(salary) from employees group by dep_name having avg(salary) > 50000;
 
#4.	Concatenate first_name and last_name as full_name.
select concat(first_name,' ',Last_name) as 'Full_Name' from employees;

# 5.	Retrieve total salary paid to all employees.
select sum(salary) as 'Total_salary' from employees;

# 6.	Extract first 3 characters from customer_name.
select substr(customername,1,3) as 'Sub_Str' from customers;
select * from customers;

# 7.	Find cities having more than 10 customers.
select city, count(customernumber) as 'Total-Customers' from customers group by city having count(customernumber) > 10;


# 8.	Calculate the number of days between order_date and delivery_date.
select datediff(shippeddate,orderdate) as 'Delivery_Duration' from orders;

# 9.	Retrieve total sales amount product-wise.
select productcode,sum(sales) as 'Total_Sales' from orderdetails group by productcode;

#10.	Find products whose names contain the word ‘Pro’.
select productcode,productname from products where productname like instr(productname,'pro');

-- INSTR(): Find position of a substring 
-- syntax: INSTR(productName,'Pro')

# 11.	Count the total number of employees in each department.
select dep_id,count(emp_id) as 'Total_Employees' from employees group by dep_id;

# 12.	Retrieve orders placed in the year 2023.
select * from orders where year(orderdate) = '2023';

# 13.	Find highest marks scored in each subject.
select subject,max(marks) as "Highest_Marks" from students group by subject;

# 14.	Replace ‘Ltd’ with ‘Limited’ in company names.
select replace(companyname,'Ltd','Limited') as 'Company_Name' from Branch_Details;

# 15.	Display month-wise total sales.
select month(orderdate) as 'Month',sum(sales) as 'Total_sales' from sales group by month(orderdate);

# 16.	Retrieve emails ending with @gmail.com.
select email from customers where right(email,10) = '@gmail.com';


#17.	Count distinct customers who placed orders.
select count(distinct(customernumber)) as 'Customers' from orders;

# 18.	Retrieve departments with average salary below 40,000.
select dep_id,avg(salary) as 'Avg_Salary' from employees group by dep_id having avg(salary) < 40000;

# 19.	Find the average salary of employees department-wise.
select dep_id,avg(salary) as 'Avg_Salary' from employees group by dep_id;


#20.	Extract username from email address.
select substring_index(email,'@',1) as 'User_name' from customers;

-- SUBSTRING_INDEX() returns a part of a string before or after a specified delimiter.
-- SUBSTRING_INDEX(string, delimiter, count)
-- Parameters
-- string → The original string.
-- delimiter → The character or string used to split the text.
-- count
-- +1  → Returns everything before the specified delimiter.
-- -1 → Returns everything after the specified delimiter.

# 21.	Display the total number of orders placed each month.
select month(orderdate),sum(sales) as 'Total_sales' from orders group by month(orderdate);

#22.	Find orders placed on weekends.
select * from orders where dayofweek(orderdate) in (1,7);
-- 1 sunday , ..... , 7 Saturday


# 23.	Retrieve total quantity sold for each product.
select product_code, sum(qtysold) as 'Products_Sold' from products group by product_code;

# 24.	Remove leading and trailing spaces from names.
select trim(user_name) as 'Name' from user_Details;

# 25.	Retrieve employees who joined in the current year.
select * from employees where year(joindate) = year(curdate());

# 26.	Find maximum and minimum product price.
select max(totalprice) as 'Max_Price', min(totalprice) as 'Min_Price' from products;


# 27.	Retrieve products whose total sales exceed 1,00,000.
select product_code,sum(sales) as 'Total_Sales' from sales group by product_code having sum(sales) > 100000;

# 28.	Mask last 4 digits of phone numbers.

#29.	Display subjects with average marks above 75.
select subjects, avg(marks) from students group by subjects having avg(marks) > 75;

# 30.	Retrieve total sales region-wise.
select region,sum(sales) as 'Total_Sales' from sales group by region;

# 31.	Display employee age using date_of_birth.
select timestampdiff(year,dateofbirth,curdate()) as 'Age' from employees;

-- TIMESTAMPDIFF(YEAR, date1, date2)       Difference in years (useful for age)


# 32.	Count employees department-wise.
select dep_id,count(emp_id) as 'Total_Employees' from employees group by dep_id;

# 33.	Retrieve orders placed in the current month.
select * from orders where month(orderdate) = month(curdate());

# 34.	Find delayed orders where delivery_date is greater than expected_date.
select * from orders where datediff(deliverydate,expecteddate) > 0; 

# 35.	Find customers who placed more than 5 orders.
select customer_id,count(order_id) as 'Total_Orders' from orders group by customer_id having count(order_id) > 5;

# 36.	Display length of each product name.
select length(productname) as 'length' from products;

# 37.	Retrieve stores generating the highest revenue.
select store_name, sum(sales) as 'Total_Sales' from Sales group by store_name order by sum(sales) desc limit 1;

-- OR

select store_name, sum(sales) as 'Total_Sales' from Sales group by store_name
having sum(sales) = 
(select max(sales) from (select sum(sales) as sales from sales group by store_name) as T); 


# 38.	Filter grouped data using HAVING clause.
select customer_id,count(order_id) as 'Total_Orders' from orders group by customer_id having count(order_id) > 5;


# 39.	Find departments having more than 5 employees.
select dep_id,count(emp_id) as 'Total_Employees' from employees group by dep_id having count(emp_id) > 5;

# 40.	Extract month and year from order_date.
select monthname(orderdate) as 'month' , year(orderdate) as 'Year' from orders;
