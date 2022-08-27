# practice

use sql_intro;
show tables;

create table employees (Emp_ID int primary key, Emp_Name varchar(25), age int, Gender char(1), DOJ date, Dept varchar(20), City varchar(15), Salary float);

describe employees;

insert into employees values
(101, "Jimmy", 35, "M", "2005-05-30", "Sales", "Chicago", 70000),
(102, "Shane", 30, "M", "1999-06-25", "Marketing", "Seattle", 55000),
(103, "Marry", 28, "F", "2009-03-10", "Product", "Boston", 62000),
(104, "Dwayne", 37, "M", "2011-07-12", "Tech", "Austin", 57000),
(105, "Sara", 32, "F", "2017-10-27", "Sales", "New York", 72000),
(106, "Ammy", 35, "F", "2014-12-20", "IT", "Seattle", 80000),
(107, "Jack", 40, "M", "2012-07-14", "Finance", "Houston", 100000),
(108, "Angela", 36, "F", "2007-02-04", "Tech", "New York", 110000),
(109, "Marcus", 25, "M", "2010-07-18", "HR", "Boston", 90000),
(110, "David", 34, "M", "2009-08-25", "Product", "Miami", 75000),
(111, "Rose", 28, "F", "2011-02-27", "Tech", "Chicago", 60000),
(112, "Sophia", 33, "F", "2013-09-21", "HR", "Houston", 65000),
(113, "Amelia", 30, "F", "2018-10-15", "Finance", "Austin", 55000),
(114, "Robert", 40, "M", "2015-12-18", "Sales", "Detroit", 95000),
(115, "William", 36, "M", "2016-04-20", "IT", "Chicago", 83000),
(116, "John", 32, "M", "2004-08-09", "Marketing", "Miami", 67000),
(117, "Bella", 29, "F", "2002-06-11", "Tech", "Detroit", 72000),
(118, "Maya", 25, "F", "2018-10-15", "IT", "Houston", 48000),
(119, "Alice", 37, "F", "2019-05-28", "Product", "Seattle", 76000),
(120, "Joseph", 45, "M", "2016-11-23", "Sales", "Chicago", 115000);

select * from employees;
select * from emp_details;
select * from sales;
select * from c_product;


select distinct city from employees;
select distinct dept from employees;

# average age in each department
select dept, round(avg(age), 1) as age_average
from employees
group by dept;

# average salary of employees in each city
select city, round(avg(salary), 2) as salary_average
from employees 
group by city;

# total salary of all employees in each department
select dept, round(sum(salary), 2) as total_salary 
from employees 
group by dept 
order by dept;

# total number of employees in each city and group it in the order of emp_id (count of employees)
select count(Emp_Id), city as employee_count
from employees
group by city
order by count(emp_id) desc;

# number of employees that joined the company each year
select year(DOJ) as Year, count(emp_ID) as employee_count
from employees
group by year(doj)
order by year(doj);

# Sales Table
create table sales (product_id int, sell_price float, quantity int, state varchar(20));
describe sales;
select * from sales;

insert into sales values
(121, 320.0, 3, 'California'),
(121, 320.0, 6, 'Texas'),
(121, 320.0, 4, 'Alaska'),
(123, 290.0, 2, 'Texas'),
(123, 290.00, 7, 'California'),
(123, 290.00, 4, 'Washington'),
(121, 320.0, 7, 'Ohio'),
(121, 320.0, 2, 'Arizona'),
(123, 290.00, 8, 'Colorado');

select * from sales;

# calculate the revenue (selling price x quantity)
select product_id, sum(sell_price * quantity) as revenue
from sales
group by product_id;

# Cost table of products

create table c_product (product_id int, cost_price float);

insert into c_product values
(121, 270.0),
(123, 250.0);

select * from c_product;
select * from sales;

# total profit that was made from both products
# profit = (sell price - cost price) * quantity

select c.product_id, sum((s.sell_price - c.cost_price) * s.quantity) as profit
from sales as s inner join c_product as c
where s.product_id = c.product_id
group by c.product_id;

select * from employees;

# select city with more than 2 employees
select city, count(emp_id)
from employees
group by city
having count(emp_id) > 2;

# dept with employees age older than 35
select dept, count(emp_id)
from employees
where age > 35
group by dept;

# dept where avg salary is > 75,000
select dept, avg(salary) as average_salary
from employees
group by dept
having avg(salary) > 75000;

# city where total salary is > 200000
select city, sum(salary) as total_salary
from employees
group by city
having sum(salary) > 200000;

# dept with more the 2 employees
select dept, count(*) as emp_count
from employees
group by dept
having count(*) > 2;

# city that have more than 2 employees apart from houston
select city, count(*) as emp_count
from employees
where city != 'houston'
group by city
having count(*) > 2;

# total number of emp for each dept that have an avg salary > 75000
# aggregate function in having that does not appear on select clause
select dept, count(*) as emp_count
from employees
group by dept
having avg(salary) > 75000;

# aggregate function in having that also appear on select clause
select dept, count(*) as emp_count, avg(salary)
from employees
group by dept
having avg(salary) > 75000;













