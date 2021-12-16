USE my_guitar_shop;

SET SQL_SAFE_UPDATES = 0;

DELETE 
FROM administrators 
WHERE CONCAT_WS(' ', first_name, last_name) = 'Joel Murach';

SELECT * FROM administrators;