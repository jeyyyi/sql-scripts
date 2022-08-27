# review

show databases;
show tables;
select * from client;
describe client;

create database sql_intro;
show databases;
use sql_intro;
show tables;
create table emp_details (Name varchar(25), Age int, Sex char(1), DOJ date, City varchar(15), Salary float);
describe emp_details;

insert into emp_details
values("Jimmy", 35, "M", "2005-05-30", "Chicago", 70000),
("Shane", 30, "M", "1999-06-25", "Seattle", 55000),
("Marry", 28, "F", "2009-03-10", "Boston", 62000),
("Dwayne", 37, "M", "2011-07-12", "Austin", 57000),
("Sara", 32, "F", "2017-10-27", "New York", 72000),
("Ammy", 35, "F", "2014-12-20", "Seattle", 80000);

select * from emp_details;

select distinct city from emp_details;

select count(name) as count_name from emp_details;

select sum(salary) as salary_total from emp_details;
select avg(salary) as salary_avg from emp_details;

select name, age, city from emp_details;

select sex, city from emp_details
where sex = "F";

select * from emp_details
where city = 'chicago' or city = 'austin';

SELECT * from emp_details
where city in ('chicago', 'austin');

SELECT * from emp_details
where DOJ between '2000-01-01' and '2010-12-31';

select * from emp_details
where age > 30 and sex = 'M';

select sex, sum(salary) as total_salary from emp_details
group by sex;

select * from emp_details
order by salary desc;

-- OTHER SQL FUNCTIONS

select (10 + 20) as addition;

select length('india') as total_length;

select repeat('@', 10) as repeat_try;

select upper('philippines') as uppercase;

select curdate();

select day(curdate());

select now();

# String functions

select upper('philippines') as upper_case;
select lower('PHILIPPINES') as lower_case;
select character_length('philippines') as total_length;	

# using char_length on a table
select * from emp_details;
select name, char_length(name) as total_length
from emp_details;

select concat("Philippines", " is", " in", " Asia") as concatenated;

# using concat on a table
select name, age, concat(name, " - ", city) as concatenated
from emp_details;

select reverse('Philippines');

# using reverse on a table
select reverse(name) as reversed_name
from emp_details;

select replace("Orange is vegetable", "vegetable", "fruit");

select length("     Philippines     ");

select ltrim("     Philippines     ");
select length(ltrim("     Philippines     "));

select rtrim("     Philippines     ");
select length(rtrim("     Philippines     "));

select trim("     Philippines     ");
select length(trim("     Philippines     "));

select position("fruit" in "Orange is a fruit") as name;

select ascii('a');

select * from emp_details;

# using group by

# find average salary of employees per city
select city, avg(salary) as avg_salary 
from emp_details
group by city;



