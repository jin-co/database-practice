-- every schema has function list: Programmability -> Functions

/*============= AGREGATION =============*/

SELECT COUNT(*) FROM movies;

SELECT MAX(price) FROM movies;

SELECT AVG(price) FROM movies;

SELECT MIN(price) FROM movies;

SELECT SUM(price) FROM movies;

/*------------- GROUP BY -------------*/
-- Columns that are not aggregation need to be in the 'GROUP BY'
SELECT SUM(price), name FROM movies GROUP BY name; 