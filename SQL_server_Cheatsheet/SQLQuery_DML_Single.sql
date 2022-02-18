/* SELECT */ 
SELECT * FROM Customers;

SELECT TOP (3) * FROM Customers; -- limit 3 top

-- IS (NOT)NULL
SELECT name FROM movies WHERE name IS NOT NULL;


-- CONCAT
SELECT * FROM movies;

SELECT name + ' ' + description FROM movies; -- can't concat string with number

SELECT name + '''s ' + description FROM movies; -- can't concat string with number

-- LIKE
SELECT name FROM movies WHERE name LIKE 'm%'; 

/* wild card */
-- %
-- - anything (0 or many)
SELECT name FROM movies WHERE name LIKE 'm%'; -- ~% anything begins with m

-- _
-- - anything (only one letter)
SELECT name FROM movies WHERE name LIKE 'm_'; 

-- ORDER BY
SELECT * FROM Customers ORDER BY CustomerId;

-- TOP
SELECT TOP(2) name FROM movies ORDER BY 1; 

-- - PERCENT
SELECT TOP 50 PERCENT name FROM movies ORDER BY 1; 

-- DISTINCT
SELECT DISTINCT name FROM movies;

SELECT DISTINCT name, price FROM movies; -- name and price distinct

SELECT COUNT(DISTINCT name) FROM movies;

/* DELETE */
DELETE FROM Customers WHERE CustomerId = 1;

/* UPDATE */
UPDATE Customers SET ContactName = 'Tom' WHERE CustomerId = 1;

/* TRUNCATE */
TRUNCATE TABLE Customers; -- deletes all the data