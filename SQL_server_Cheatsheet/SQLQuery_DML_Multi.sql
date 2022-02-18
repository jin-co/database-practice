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