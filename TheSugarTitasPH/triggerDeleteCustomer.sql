-- TRIGGER FOR DELETE ORDER 

CREATE TRIGGER orddlt
AFTER DELETE
ON orders FOR EACH ROW
INSERT INTO delete_history
    VALUES (id, old.Order_ID, old.Order_Date, 
            old.MOP, old.Customer_ID,'Delete');