USE my_guitar_shop;

SELECT order_date,
	   DATE_FORMAT(order_date, '%Y') AS four_digit_year,
       DATE_FORMAT(order_date, '%b-%d-%Y') AS 'Mon-DD-YYYY',
       DATE_FORMAT(order_date, '%r') AS 'h:m:s am/pm',
       DATE_FORMAT(order_date, '%m/%d/%y %H:%i') AS 'MM/DD/YY HH:MI'
FROM orders;