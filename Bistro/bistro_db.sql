CREATE SCHEMA bistro_db;
use bistro_db;

select * from employee_tbl;
select * from product_tbl;
select * from transaction_tbl;
select * from orders_tbl;

CREATE TABLE employee_tbl 
(
Employee_ID VARCHAR (10) PRIMARY KEY,
Acct_Pass VARCHAR (25),
Employee_Name VARCHAR (50),
Birthdate DATE,
Contact_No VARCHAR (15)
);

CREATE TABLE product_tbl
(
Product_ID VARCHAR (10) PRIMARY KEY,
Product_Name VARCHAR (50),
Description VARCHAR (100),
Price DECIMAL (12, 2),
Category VARCHAR (20),
Stocks INT
);


CREATE TABLE transaction_tbl
(
Transaction_ID VARCHAR (20) PRIMARY KEY,
Transaction_Date DATE,
Customer_Name VARCHAR (50),
Employee_ID VARCHAR(10)
);

CREATE TABLE orders_tbl
(
Transaction_ID VARCHAR (20),
Product_ID VARCHAR (10),
Quantity Int,
PRIMARY KEY (Transaction_ID, Product_ID), -- composite + foreign
FOREIGN KEY (Transaction_ID) REFERENCES Transaction_Tbl (Transaction_ID),
FOREIGN KEY (Product_ID) REFERENCES Product_Tbl (Product_ID)
);

CREATE TABLE temp_ordertbl
(
temp_id varchar(10)  auto_increment,
transaction_ID varchar(10),
product_ID varchar(10),
quantity int
);

