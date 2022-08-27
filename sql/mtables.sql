# Multiple Tables

CREATE DATABASE exerciseMultipleTables;

USE exerciseMultipleTables;
SHOW tables;

SELECT * FROM client;
SELECT * FROM detail;
SELECT * FROM ordert1;
SELECT * FROM product;

-- List clientID, name, and his corresponding orders from the order table if the order was made in 2011
SELECT C.ClientNo, concat(C.FirstName, ' ', C.MidName, ' ', C.SurName) AS 'CLIENT NAME', O.InvoiceNo
FROM Client C 
JOIN OrderT1 O ON C.ClientNo = O.ClientNo
WHERE OrderDate LIKE '%2011%';

SELECT C.clientNo, concat(C.FirstName, ' ', C.MidName, ' ', C.SurName) AS 'Client Name', O.InvoiceNo
FROM Client C 
JOIN OrderT1 O ON C.ClientNo = O.ClientNo
WHERE YEAR(O.OrderDate) = 2011;

-- List the client id and the product codes with order qty ordered by each client
SELECT C.ClientNo, D.ProdCode, D.Quantity
FROM Client C 
JOIN OrderT1 O ON C.ClientNo = O.ClientNo
JOIN Detail D ON O.InvoiceNo = D.InvoiceNo;

SELECT C.ClientNo, D.ProdCode, D.Quantity
FROM client C 
INNER JOIN ordert1 O ON C.ClientNo = O.ClientNo
INNER JOIN detail D ON O.InvoiceNo = D.InvoiceNo;
    
-- Without client_t // same result with above
SELECT O.ClientNo, D.ProdCode, D.Quantity
FROM ordert1 O
JOIN detail D ON O.InvoiceNo = D.InvoiceNo;
    
-- List the client id,  the description of the product ordered including the unit cost.  
-- Display unique  records only (Find what keyword to use to display unique records)
-- w/ DISTINCT - returns 21 rows | w/o DISTINCT - returns 25 rows (C1 Ib, C3 Con, C2 CTun, C5 Con)
-- tables needed CLIENT, ORDER, DETAIL, PRODUCT
SELECT DISTINCT C.ClientNo, P.ProductDescription, P.UnitCost
FROM CLIENT C 
JOIN ORDERT1 O ON C.ClientNo = O.ClientNo
JOIN DETAIL D ON O.InvoiceNo = D.InvoiceNo
JOIN PRODUCT P ON D.ProdCode = P.ProductCode;

SELECT DISTINCT C.ClientNo, P.ProductDescription, P.UnitCost
FROM client C
INNER JOIN ordert1 O ON C.ClientNo = O.ClientNo
INNER JOIN detail D ON O.InvoiceNo = D.InvoiceNo
INNER JOIN product P ON D.ProdCode = P.ProductCode;
    
-- without client_t //same result with above
SELECT DISTINCT O.ClientNo, P.ProductDescription, P.UnitCost
FROM ordert1 O
JOIN detail D ON O.InvoiceNo = D.InvoiceNo
JOIN product P ON D.ProdCode = P.ProductCode;

-- Display the amount (qty*unitcost) bought by client for each product (common attribute are used in using ON)
SELECT Quantity*UnitCost AS 'Amount'
FROM detail D 
JOIN product P ON D.ProdCode = P.ProductCode
JOIN Ordert1 O ON D.InvoiceNo = O.InvoiceNo;

SELECT O.clientNo, P.ProductCode, P.ProductDescription, quantity*unitCost as 'AMOUNT'
FROM Ordert1 O 
JOIN Detail D ON O.invoiceNo = D.invoiceNo
JOIN Product P ON D.ProdCode = P.ProductCode;
    
-- Display the total amount bought by each client (when aggregate use grp by)
SELECT ClientNo, SUM(Quantity*UnitCost) AS 'Amount'
FROM Detail D 
JOIN Product P ON D.ProdCode = P.ProductCode
JOIN Ordert1 O ON D.InvoiceNo = O.InvoiceNo
GROUP BY ClientNo;

SELECT O.clientNo, SUM(quantity*unitCost) as 'AMOUNT'
FROM Ordert1 O 
JOIN Detail D ON O.invoiceNo = D.invoiceNo
JOIN Product P ON D.ProdCode = P.ProductCode
GROUP BY ClientNo;

-- Display clientName, creditLimit, product bought (description) and the amount for each product
SELECT concat(C.FirstName, ' ', C.MidName, ' ', C.SurName) AS 'Client Name', 
C.CreditLimit, P.ProductDescription, (UnitCost*Quantity) AS 'Amount'
FROM Client C 
JOIN Ordert1 O ON C.ClientNo = O.ClientNo
JOIN Detail D ON O.InvoiceNo = D.InvoiceNo
JOIN PRODUCT P ON D.ProdCode = P.ProductCode;
    
SELECT concat(C.FirstName, ' ', C.MidName, ' ', C.SurName) AS 'Client Name', 
C.CreditLimit, D.ProdCode, P.ProductDescription, (UnitCost*Quantity) AS 'AMOUNT'
FROM Client C 
JOIN Ordert1 O ON C.ClientNo = O.ClientNo
JOIN Detail D ON O.InvoiceNo = D.InvoiceNo
JOIN Product P ON D.ProdCode = P.ProductCode;
 
-- Display the invoiceNo and the product details, corresponding to the product bought. Product details will include all fields in the product table
SELECT D.InvoiceNo, D.ProdCode, D.Quantity, 
P.ProductCode, P.ProductDescription, P.UnitCost, P.Category
FROM Detail D 
JOIN Product P ON D.ProdCode = P.ProductCode;

SELECT D.InvoiceNo, D.ProdCode, P.ProductDescription, P.UnitCost
FROM Detail D 
JOIN Product P ON D.ProdCode = P.ProductCode;

-- Client ID, Client Name together with the  invoice corresponding to the client. Display client even he didnt make any purchase
SELECT C.ClientNo, concat(C.FirstName, ' ', C.MidName, ' ', C.SurName) AS 'Client Name', O.InvoiceNo
FROM Client C 
LEFT JOIN Ordert1 O ON C.ClientNo = O.ClientNo;

-- ClientId and all products he purchased (product code only) Display all product codes even if not purchased by client
SELECT O.ClientNo, P.ProductCode
FROM Ordert1 O 
JOIN Detail D ON O.InvoiceNo = D.InvoiceNo
RIGHT JOIN Product P ON D.ProdCode = P.ProductCode;

-- Count how many clients purchased have more than 1 invoice
SELECT invoiceNo, clientNo
FROM OrderT1
GROUP BY clientNo
HAVING Count(*) > 1;