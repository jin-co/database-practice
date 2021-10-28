SELECT category_name, 
	   product_name, 
	   list_price
FROM categories
	JOIN products USING(category_id)
ORDER BY category_name ASC, product_name ASC;
