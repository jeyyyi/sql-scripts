CREATE DATABASE thesugartitasph;
USE thesugartitasph;

SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM product;
SELECT * FROM order_line;
--------------------------------------------------------------------------------------
-- entity integrity constraint
-- Order_line table has a composite keys which are Order_ID and Product_ID
ALTER TABLE order_line
ADD PRIMARY KEY (Order_ID, Product_ID);

-- Order_ID is a primary key, and therefore should be NOT NULL
ALTER TABLE order_line
MODIFY Order_ID varchar(10) NOT NULL;

-- Product_ID is a primary key, and therefore should be NULL
ALTER TABLE order_line
MODIFY Product_ID varchar(10) NOT NULL;
--------------------------------------------------------------------------------------
-- referential integrity constraint
-- Orders table has a foreign key Customer_ID from customer table and is defined with a delete cascade.
ALTER TABLE orders
	ADD CONSTRAINT orders_fk FOREIGN KEY(Customer_ID)
    REFERENCES customer(Customer_ID)
	ON DELETE CASCADE;

-- Alter Order_Product table to identify the first foreign key and define it with a delete cascade and update cascade
ALTER TABLE order_line
ADD CONSTRAINT orderline_fk FOREIGN KEY(Order_ID)
REFERENCES orders(Order_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Alter Order_Product table to identify the second foreign key and define it with a delete cascade and update cascade:    
ALTER TABLE order_line
ADD CONSTRAINT orderline_fk1 FOREIGN KEY(Product_ID)
REFERENCES product(Product_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;
--------------------------------------------------------------------------------------
-- DML 
SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM product;
SELECT * FROM order_line;


-- Add two new customers in the Customer table with their corresponding values, no attribute must be null.
INSERT INTO Customer
VALUES ('C0031', 'Romero', 'Edgar', 'V', '09235400987', '7734', 'Linawan', 'Gumaoc Central', 'San Jose Del Monte', '3023'),
('C0032', 'Peters', 'John', 'K', '09451122345', 'Lot 4 Blk 3', 'Roosevelt', 'Barracks-Tala', 'Caloocan', '1427');


-- Update the Street address of customer C0007 in Customer table to 'Mangga' Street.
UPDATE Customer 
SET Street = 'Mangga'
WHERE Customer_ID = 'C0007';

-- Update Orders table's Mode of Payment of customer C0011 with order O0021.
UPDATE Orders
SET MOP = 'COD'
WHERE ((Order_ID = 'O0021') AND (Customer_ID = 'C0011'));

-- Display the Customer's full name, and the city which they reside together with the zip code that starts with '30'. Sort the records by their Last name.
SELECT Customer_ID, CONCAT(First_Name, ' ', Mid_Initial, '. ', Last_Name) AS 'Customer Name', City, ZipCode
FROM Customer
WHERE ZipCode LIKE '30%'
ORDER BY Last_Name;

-- Display how many orders chose Gcash as their mode of payment.
SELECT COUNT(*) AS 'Gcash Payers'
FROM Orders
WHERE MOP = 'Gcash';

-- Display all the ProductID, its category and Price that ranges from 300 to 600 pesos.
-- Sort the records by price.
SELECT Product_ID, Category, Price
FROM Product
WHERE (Price BETWEEN 300 AND 600)
ORDER BY Price;

-- Delete all orders of Customer C0005.
DELETE FROM Orders
WHERE Customer_ID = "C0005";
--------------------------------------------------------------------------------------
