USE my_guitar_shop;

SELECT category_name
FROM categories c
WHERE NOT EXISTS(
	SELECT * FROM products
    WHERE category_id = c.category_id);