SELECT * FROM films WHERE length_min > 120;
SELECT * FROM screenings;
SELECT * FROM films;

SELECT f.name, COUNT(s.film_id) FROM screenings s
JOIN films f ON f.id = s.film_id
GROUP BY film_id
LIMIT 1;

-- How many bookings did the film ‘Jigsaw’ have in October 2017
SELECT COUNT(*) AS no_bookings FROM bookings 
WHERE screening_id IN
(SELECT id FROM screenings 
WHERE film_id = 5);

SELECT COUNT(*) FROM bookings
WHERE screening_id IN(
SELECT id FROM screenings WHERE film_id = 5);

-- Which 5 customers made the most bookings in October 2017
SELECT c.first_name, c.last_name, COUNT(b.id) AS no_bookings FROM bookings b 
JOIN customers c ON c.id = b.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY no_bookings DESC
LIMIT 5;

-- Which film was shown in the Chaplin room most often in October 2017
SELECT * FROM films;
SELECT * FROM rooms;
SELECT * FROM screenings;

SELECT f.name, COUNT(r.name) AS no_screenings FROM films f
JOIN screenings s ON f.id = s.film_id 
JOIN rooms r ON r.id = s.room_id
WHERE r.id = 1
GROUP BY f.name
ORDER BY no_screenings DESC
LIMIT 1;

-- How many of the customers made a booking in October 2017
SELECT COUNT(*) FROM customers;
SELECT * FROM bookings;
SELECT COUNT(DISTINCT(customer_id)) AS no_of_customers FROM bookings;

-- Select the film id and start time from the screenings table for the date of 20th of October 2017.
SELECT film_id, start_time FROM screenings
WHERE DATE(start_time) = '2017-10-20';

-- Select all the data from the screenings table for the start time between the 6th and 13th of 
-- October 2017.
SELECT * FROM screenings
WHERE DATE(start_time) BETWEEN '2017-10-06' AND '2017-10-13';

-- Select all the data from the screenings table for October 2017.
SELECT * FROM screenings
WHERE MONTH(start_time) = '10'
AND YEAR(start_time) = '2017';




