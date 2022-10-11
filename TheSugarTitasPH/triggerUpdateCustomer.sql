-- TRIGGER FOR UPDATE CUSTOMER DEETS

Delimiter |
CREATE TRIGGER custupdt
AFTER UPDATE
ON customer FOR EACH ROW
BEGIN
INSERT INTO update_history
    VALUES (id, old.Customer_ID, old.Last_Name, old.First_Name, old.Mid_Initial,
            old.Contact_No, old.House_No, old.Street, old.Brgy, old.City,
            old.zipcode,'Initial');
INSERT INTO update_history
    VALUES (id, new.Customer_ID, new.Last_Name, new.First_Name, new.Mid_Initial, 
            new.Contact_No, new.House_No, new.Street, new.Brgy, new.City,
            new.zipcode,'Updated');
End; |