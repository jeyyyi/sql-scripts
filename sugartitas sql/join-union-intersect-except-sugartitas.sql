-- sugartitas JOIN/UNION/INTERSECT/EXCEPT

-- JOIN 
-- 1.	List the ID's together with the full name of those customer whose Mode of payment is COD. 
-- 		Every customer should appear ONLY ONCE in the list. Sort the records by their Customer ID.
SELECT DISTINCT C.Customer_ID, CONCAT(C.First_Name, " ", C.Last_Name) AS 'Full Name', O.MOP 
FROM customer C JOIN orders O
ON C.Customer_ID = O.Customer_ID
WHERE O.MOP LIKE 'COD'
ORDER BY C.Customer_ID;

-- 2.	List the Order IDs, Customer IDs together with their Full names, date ordered and the quantity of orders of those customers 
-- 		who have ordered more than one product in March 2019 only.
SELECT O.Order_ID, C.Customer_ID, CONCAT(First_Name, " ", Last_Name) AS 'Full Name', Order_Date, Quantity
FROM customer C JOIN orders O 
ON C.Customer_ID = O.Customer_ID 
JOIN order_line L 
ON O.Order_ID = L.Order_ID WHERE Quantity > 1 AND Order_Date BETWEEN '2019-03-01' AND '2019-03-31';

-- 3.	List the ID, full name, the contact number, and the full address of customer who have ordered already. The customer's order id and the date of order should be displayed too. 
-- 		If the customer ordered more than once, his/her name should also appear in the list more than once. Sort the records by Customer ID.
SELECT C.Customer_ID, CONCAT(First_Name, " ", Last_Name) AS 'Full Name', Contact_No, CONCAT(House_No, ", ", Street, ", ", Brgy, ", ", City) AS 'Full Address', 
Order_ID, Order_Date 
FROM customer C JOIN orders O 
ON C.Customer_ID = O.Customer_ID
ORDER BY C.Customer_ID;

-- 4.	List the customer id and order id, full name, product name and its price together with the quantity of products ordered by the customer. 
-- 		Find the total amount of each customer would be paying per transactions, then display only those who will pay the amount of 500 php or above. Sort the records by Customer_ID.
SELECT C.Customer_ID, O.Order_ID, CONCAT(First_Name, " ", Last_Name) AS Full_Name, Product_Name, Price, Quantity, (Quantity*Price) as TOTAL 
FROM customer C JOIN orders O 
ON C.Customer_ID = O.Customer_ID 
JOIN order_line L 
ON O.Order_ID = L.Order_ID 
JOIN product P 
ON L.Product_ID = P.Product_ID
GROUP BY O.Order_ID
HAVING TOTAL >= 500
ORDER BY C.Customer_ID;

-- 5.	List the customer’s id, full name, city, and name of the product he/she ordered and its corresponding category. 
-- 		Display only those who live in Caloocan and availed Skin Care or Clothing products. Sort the records by the Customer_ID.
SELECT C.Customer_ID, CONCAT(C.First_Name, ' ', C.Last_Name) AS 'Full Name', C.City, P.Product_Name, P.Category
FROM Customer C JOIN Orders O 
ON C.Customer_ID = O.Customer_ID 
JOIN Order_Line OL 
ON O.Order_ID = OL.Order_ID
JOIN Product P 
ON OL.Product_ID = P.Product_ID
WHERE ((City = 'Caloocan') AND (Category = 'Skin Care' OR 
		Category = 'Clothes'))
ORDER BY Customer_ID;

-- UNION
-- 1.	List all the Customer ID in customer table and the product id in the product table, together with their corresponding names. 
-- 		The customer id listed should be the ids of those customers living in San Jose Del Monte. 
-- 		Name the columns containing customer and product id as IDs. Name the columns containing the names as Naming.
SELECT Customer_ID AS IDs, Last_Name AS Naming 
FROM customer
WHERE City = "San Jose Del Monte"
UNION ALL
SELECT Product_ID, Product_Name
FROM product;

-- 2.	List the customer id from customer table together with the order id from orders table. 
-- 		The customer must reside in any zipcode that starts with 30. And the order must have a MOP of Gcash.
SELECT Customer_ID AS 'IDs'
FROM Customer WHERE ZipCode LIKE '30%'
UNION
SELECT Order_ID
FROM Orders WHERE MOP = 'Gcash';

-- INTERSECT/IN
-- 1.	List the names of the customers who have ordered a product from February 2019 to March 2019 only.
SELECT CONCAT(First_Name, " ", Last_Name) AS Full_Name
FROM customer
WHERE Customer_ID IN(SELECT Customer_ID FROM orders
WHERE Order_Date BETWEEN '2019-02-01' AND '2019-03-31');

-- 2.	Display the ID, their full names and city of customers who resides in Marilao whose Mode Of Payment is COD.
SELECT Customer_ID,  CONCAT(First_Name, " ", Last_Name) AS 'Full Name', City
FROM Customer
WHERE City = 'Marilao' AND Customer_ID IN (SELECT Customer_ID FROM Orders 
WHERE MOP = 'COD');

-- 3.	List all the records from orders table. Display only those orders ordered with 1 product only in the last 2 weeks of February 2019.
SELECT * FROM Orders 
WHERE (Order_Date BETWEEN '2019-02-14' AND '2019-02-28') 
AND Order_ID IN (SELECT Order_ID FROM Order_Line 
WHERE Quantity = 1);

-- 4.	List all the records of Customer from San Jose Del Monte who ordered in the whole March 2019.
SELECT * FROM Customer
WHERE City = 'San Jose Del Monte' AND Customer_ID IN (SELECT Customer_ID FROM Orders
WHERE Order_Date BETWEEN '2019-03-01' AND '2019-03-31');

-- EXCEPT/NOT IN 
-- 1.	List all the records of those customers who haven't ordered any products.
SELECT *
FROM customer
WHERE Customer_ID 
NOT IN (SELECT Customer_ID FROM orders);

-- 2.	List all the records of those customers who did not order in the month of January 2019.
SELECT *
FROM customer
WHERE Customer_ID NOT IN(SELECT Customer_ID FROM orders 
WHERE Order_Date BETWEEN '2019-01-01' AND '2019-01-31');

-- 3.	List all the records of customers except those customers who chose COD as their Mode of Payment. 
-- 		Customers who haven't ordered anything yet can appear on the list. Sort the records by Customer ID.
SELECT *
FROM Customer
WHERE Customer_ID 
NOT IN (SELECT Customer_ID FROM Orders WHERE MOP = 'COD')
ORDER BY Customer_ID;


-- 4.	List all the records of those product that has not been ordered by any customer.
SELECT *
FROM product
WHERE Product_ID 
NOT IN (SELECT Product_ID FROM order_line);