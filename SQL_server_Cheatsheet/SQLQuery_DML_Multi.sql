SELECT * FROM Bills b
JOIN Suppliers s ON b.SupplierId = s.SupplierId; -- inner join

/* JOIN */
-- (INNER) JOIN
SELECT m.name FROM movies m JOIN cinemas c ON (m.CinemaId = c.CinemaId);

-- LEFT OUTER JOIN
SELECT m.name FROM movies m LEFT OUTER JOIN cinemas c ON (m.CinemaId = c.CinemaId);

-- RIGHT OUTER JOIN
SELECT m.name FROM movies m RIGHT OUTER JOIN cinemas c ON (m.CinemaId = c.CinemaId);

/* SUBQUERY */
SELECT * FROM cinemas 
WHERE CinemaId = (SELECT TOP 1 CinemaId FROM movies);

/* UNION */ 
-- -> must have the equal number of columns
-- -> must have the same type
-- -> must be in the same order
-- -> doesn't allow duplicate
SELECT name, 'F' FROM movies WHERE name = 'life'
UNION
SELECT name, 'A' FROM Movies WHERE name = 'RACE';

/* UNION ALL */ 
-- -> allowS duplicate
SELECT name, 'F' FROM movies WHERE name = 'life'
UNION ALL
SELECT name, 'A' FROM Movies WHERE name = 'RACE';

/* EXISTS */
-- -> returns true if the select returns one or more records
SELECT * FROM cinemas WHERE EXISTS (SELECT name FROM cinemas WHERE name = 'life');