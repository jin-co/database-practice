SELECT category_name,
	   product_id
FROM categories
	LEFT JOIN products USING(category_id)
WHERE product_id IS NULL;