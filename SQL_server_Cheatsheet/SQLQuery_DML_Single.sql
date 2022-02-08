-- SELECT
SELECT * FROM Customers;

SELECT TOP (3) * FROM Customers; -- limit 3 top

-- ORDER BY
SELECT * FROM Customers ORDER BY CustomerId;

-- DELETE
DELETE FROM Customers WHERE CustomerId = 1;

-- UPDATE
UPDATE Customers SET ContactName = 'Tom' WHERE CustomerId = 1;

-- TRUNCATE
TRUNCATE TABLE Customers; -- deletes all the data