USE my_guitar_shop;

SELECT category_name,
	   COUNT(*) AS products_count,
       MAX(list_price) AS most_expensive_product
FROM categories
	JOIN products USING(category_id)
GROUP BY category_name
ORDER BY products_count DESC;