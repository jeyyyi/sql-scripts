# review 3

# JOIN
show databases;
create database sql_joins;

use sql_joins;
show tables;

# inner join 
# return all rows from  multiple tables as long as conditions are met

create table cricket (cricket_id int auto_increment, name varchar(30), primary key(cricket_id));
create table football (football_id int auto_increment, name varchar(30), primary key(football_id));

insert into cricket (name)
values ('Stuart'), ('Michael'), ('Johnson'), ('Hayden'), ('Fleming');

insert into football (name)
values ('Stuart'), ('Johnson'), ('Hayden'), ('Langer'), ('Astle');

select * from cricket;
select * from football;

# find students that are part of both teams

select * from cricket as c inner join football as f
on c.name = f.name;

select c.cricket_id, c.name, f.football_id, f.name
from cricket as c inner join football as f
where c.name = f.name;