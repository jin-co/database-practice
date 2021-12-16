USE my_guitar_shop;

SELECT category_name,
       COUNT(product_name) AS product_count
FROM categories JOIN products USING(category_id)
GROUP BY category_id
ORDER BY 2 DESC
LIMIT 1;