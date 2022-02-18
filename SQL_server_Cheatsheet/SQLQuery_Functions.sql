-- every schema has function list: Programmability -> Functions
/*============= Configuration =============*/
SELECT @@SERVERNAME;

SELECT @@VERSION;

SELECT @@CONNECTIONS, @@CPU_BUSY, @@CONNECTIONS;

/*============= STRING =============*/
-- UPPER
SELECT UPPER(name) FROM Movies;

-- LOWER
SELECT LOWER(name) FROM Movies;

-- LEN
-- -> returns the number of characters in a string
SELECT LEN(name) FROM Movies;

-- SOUNDEX
SELECT name FROM Movies WHERE SOUNDEX(name) = SOUNDEX('TOM');

/*============= AGREGATION =============*/

SELECT COUNT(*) FROM movies;

SELECT MAX(price) FROM movies;

SELECT AVG(price) FROM movies;

SELECT MIN(price) FROM movies;

SELECT SUM(price) FROM movies;

/*------------- GROUP BY -------------*/
-- Columns that are not aggregation need to be in the 'GROUP BY'
SELECT SUM(price), name FROM movies GROUP BY name; 

/*============= DATE =============*/
-- GETDATE
SELECT GETDATE();

-- DAY
SELECT DAY(GETDATE());

-- MONTH
SELECT MONTH(GETDATE());

-- YEAR
SELECT YEAR(GETDATE());

-- DATEPART
SELECT DATEPART(WEEKDAY, GETDATE());

-- DATENAME
SELECT DATENAME(WEEKDAY, GETDATE());

-- DATEADD(what, how much, target)
SELECT DATEADD(DAY, 30, GETDATE());

SELECT DATEADD(DAY, -30, GETDATE()); -- subtracting

/*============= CUSTOM FUNCTIONS =============*/
-- name
-- parameters
-- return