USE my_guitar_shop;

SELECT FORMAT(list_price, 2) AS list_price,
	   CAST(discount_percent AS SIGNED) AS discount_percent,
       ROUND((list_price * (1 - (discount_percent / 100))), 2) AS discount_amount,
       DATE_FORMAT(date_added, '%m-%d') AS month_day_added  
FROM products;