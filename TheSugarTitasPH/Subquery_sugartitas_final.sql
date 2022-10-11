use thesugartitasph;

SELECT * FROM customer;
SELECT * FROM category;
SELECT * FROM orders;
SELECT * FROM product;
SELECT * FROM order_line;

-- 1. List the customer id, the product name and its price, the quantity of product they availed and its total amount. Sort the records by Customer id.
SELECT Customer_ID, Product_Name, P.Price, OL.Quantity, (Price*Quantity) AS 'Total Amount'
FROM Orders O JOIN Order_Line OL
ON O.Order_ID = OL.Order_ID
JOIN Product P 
ON OL.Product_ID = P.Product_ID
WHERE P.Product_ID IN (SELECT Product_ID FROM Product)
ORDER BY Customer_ID;

-- 2. Display the customer name of those customers who ordered for the whole March 2019.
SELECT CONCAT(First_Name, ' ', Last_Name) AS 'Full Name'
FROM Customer WHERE Customer_ID IN (SELECT Customer_ID FROM Orders 
WHERE order_date BETWEEN '2019-03-01' AND '2019-03-31');

-- 3. List the name of the Products C0002 purchased. Display only those products that is not lower than 299.
SELECT Customer_ID, Product_Name, Price
FROM orders O JOIN order_line L ON O.Order_ID = L.Order_ID
JOIN product P ON L.Product_ID = P.Product_ID
WHERE Price>=300 AND Customer_ID IN(SELECT Customer_ID FROM orders WHERE Customer_ID = 'C0002');



-- List the customer C0007's full name and address with his/her product/s ordered together with its price, quantity and the total amount.
SELECT CONCAT(First_Name, ' ', Last_Name) AS 'Full Name', OL.Order_ID,
CONCAT(House_No, ' ', Street, ' ', Brgy, ' ', City) AS Address, P.Product_Name, Price, Quantity,(Price*Quantity) AS TOTAL, P.Category
FROM Customer C JOIN Orders O ON C.Customer_ID = O.Customer_ID
JOIN Order_line OL ON O.Order_ID = OL.Order_ID
JOIN Product P ON OL.Product_ID = P.Product_ID
WHERE C.Customer_ID = 'C0007' AND P.Category IN ('Skin Care', 'Food');


-- 4. List the Order ID and Quantity of those Orders with the top 3 highest quantity. If there is a tie, the both records should be displayed.
SELECT Order_ID, Quantity
FROM order_line
WHERE Quantity IN(SELECT * FROM(SELECT DISTINCT Quantity FROM order_line
ORDER BY Quantity DESC
LIMIT 3) AS subq)
GROUP BY Order_ID;
        
-- 5. Do requirement #4 again, but this time display the following:
--         2.1 Display the Order_ID and Quantity
--         2.2 Display the Name of the customer using the order ID
SELECT CONCAT(First_Name, " ", Last_Name) AS Full_Name, L.Order_ID, Quantity
FROM customer C JOIN orders O ON C.Customer_ID=O.Customer_ID
JOIN order_line L ON L.Order_ID = O.Order_ID 
WHERE Quantity IN(SELECT * FROM(SELECT DISTINCT Quantity FROM order_line
ORDER BY Quantity DESC
LIMIT 3) AS subq)
GROUP BY L.Order_ID;

