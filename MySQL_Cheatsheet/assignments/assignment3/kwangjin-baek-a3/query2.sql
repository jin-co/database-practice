USE my_guitar_shop;

-- insert
INSERT INTO products(
			product_id, category_id, product_code, product_name, 
			description, list_price, discount_percent, date_added)
       VALUES(
			DEFAULT, 4, "dgx_640", "Yamaha DGX 640 88-Key Digital Piano",
			"Long description to come.", 799.99, 0, sysdate());

-- update
UPDATE products SET discount_percent = 35 WHERE product_id = 11;

-- select
SELECT * FROM products;

-- delete
DELETE FROM categories WHERE category_id = 4;

DELETE FROM products WHERE product_id = 11;