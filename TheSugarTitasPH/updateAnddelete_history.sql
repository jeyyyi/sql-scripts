CREATE TABLE update_history (
    ID int primary key auto_increment NOT NULL,
    Customer_ID varchar(10) NOT NULL,
    Last_Name varchar(30) NOT NULL,
    First_Name varchar(30) DEFAULT NULL,
    Mid_Initial varchar(5) NOT NULL,
    Contact_No varchar(15) NOT NULL,
    House_No varchar(25) NOT NULL,
    Street varchar(25) NOT NULL,
    Brgy varchar(25) NOT NULL,
    City varchar(25) NOT NULL,
    zipcode varchar(5) NOT NULL,
    actions varchar(10) NOT NULL
);

ALTER TABLE update_history
ADD CONSTRAINT fkhistory_upd FOREIGN KEY (Customer_ID)
REFERENCES customer (customer_ID)
ON UPDATE CASCADE;



-- TRIGGER FOR DELETING AN ORDER
CREATE TABLE delete_history(
    id int primary key auto_increment,
    Order_ID varchar(10),
    Order_Date date,
    MOP varchar(10),
    Customer_ID varchar (10),
    Actions varchar(15)
);


SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM product;
SELECT * FROM order_line;

SELECT * FROM update_history;
SELECT * FROM delete_history;
USE THESUGARTITASPH;
-- Calling Stored Procedures 'AddCustomer'
CALL AddCustomer('C0033','Afable', 'Afrahly', 'V', '09162365345', 'Lot 12 Blk 90', 'Gomez', 'Barracks-Tala' ,'Caloocan', '1427');

-- Calling Stored Procedures 'AddOrder'
 CALL AddOrder('O0041', '2021-02-24', 'COD', 'C0032');

-- Calling 'searchcustview' VIEW
SELECT * FROM searchcustview;

-- Calling 'searchorderview' VIEW
SELECT * FROM searchorderview;


UPDATE Customer
SET Last_Name = 'Ramirez', First_Name = 'Sue', House_No = 'Lot 33 Block 22'
WHERE Customer_ID = 'C0001';


DELETE FROM Orders
WHERE Order_ID = 'O0001';

SELECT C.Customer_ID, O.Order_ID, CONCAT(First_Name, " ", 
    Last_Name) AS Full_Name, Product_Name, Price, Quantity, 
    (Quantity*Price) as TOTAL 
FROM customer C JOIN orders O 
ON C.Customer_ID = O.Customer_ID 
JOIN order_line L 
ON O.Order_ID = L.Order_ID 
JOIN product P 
ON L.Product_ID = P.Product_ID
GROUP BY O.Order_ID
HAVING TOTAL >= 500
ORDER BY C.Customer_ID;

SELECT C.Customer_ID, CONCAT(C.First_Name, ' ', C.Last_Name) AS 
'Full Name', C.City, P.Product_Name, P.Category
FROM Customer C JOIN Orders O ON C.Customer_ID = O.Customer_ID 
 JOIN Order_Line OL ON O.Order_ID = OL.Order_ID
 JOIN Product P ON OL.Product_ID = P.Product_ID
WHERE ((City = 'Caloocan') AND (Category = 'Skin Care' OR 
Category = 'Clothes'))
ORDER BY Customer_ID;


SELECT *
FROM product
WHERE Product_ID 
NOT IN (SELECT Product_ID FROM order_line);