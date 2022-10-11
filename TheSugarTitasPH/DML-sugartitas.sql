USE sugartitasph;

SELECT * FROM customer;
SELECT * FROM category;
SELECT * FROM orders;
SELECT * FROM product;
SELECT * FROM order_line;

-- SELECT UPDATE INSERT DELETE

-- Add two new customers in the Customer table with their corresponding values, no attribute must be null.
INSERT INTO Customer
VALUES ('C0031', 'Romero', 'Edgar', 'V', '09235400987', '7734', 'Linawan', 'Gumaoc Central', 'San Jose Del Monte', 3023),
('C0032', 'Peters', 'John', 'K', '09451122345', 'Lot 4 Blk 3', 'Roosevelt', 'Barracks-Tala', 'Caloocan', 1427);
   
    
-- Update the Street address of customer C0007 in Customer table to 'Mangga' Street.
UPDATE Customer 
	SET Street = 'Mangga'
	WHERE Customer_ID = 'C0007';

-- Update Orders table's Mode of Payment of customer C0011 with order O0021
UPDATE Orders
	SET MOP = 'COD'
    WHERE ((Order_ID = 'O0021') AND (Customer_ID = 'C0011'));
    
 
-- Display the Customer's full name, and the city which they reside together with the zipcode that starts with '30'.
-- Sort the records by their Lastname
SELECT Customer_ID, CONCAT(First_Name, ' ', Mid_Initial, '. ', Last_Name) AS 'Customer Name', 
City, ZipCode
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
DELETE FROM Customer
WHERE Customer_ID = "C0032";

INSERT INTO Orders
	VALUES ('O0041', '2019-04-23', 'Gcash', 'C0099');
    

