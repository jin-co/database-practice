SELECT CONCAT(last_name, ', ', first_name) AS 'full_name' 
FROM customers
WHERE last_name BETWEEN 'M%' AND 'Z%' 
	OR last_name LIKE 'Z%'
ORDER BY last_name ASC;