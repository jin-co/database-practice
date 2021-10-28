USE my_guitar_shop;

-- insert
INSERT INTO categories(category_name) VALUES("Brass");

-- update
UPDATE categories 
SET category_name = "Woodwinds"
WHERE category_id = 5;

-- select
SELECT * FROM categories;

-- delete
DELETE FROM categories
WHERE category_id = 5;
