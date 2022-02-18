SELECT * FROM Bills b
JOIN Suppliers s ON b.SupplierId = s.SupplierId; -- inner join

/* (INNER) JOIN */
SELECT m.name FROM movies m JOIN cinemas c ON (m.CinemaId = c.CinemaId);