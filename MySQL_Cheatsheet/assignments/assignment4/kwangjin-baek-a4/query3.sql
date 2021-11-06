USE my_guitar_shop;

SELECT product_name,
       SUM((item_price - discount_amount) * quantity) AS total_amount
FROM order_items
	JOIN products USING(product_id)
GROUP BY product_id
WITH ROLLUP;