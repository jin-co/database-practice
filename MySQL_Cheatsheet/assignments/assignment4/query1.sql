USE my_guitar_shop;

SELECT COUNT(*) AS orders_count,
	   SUM(tax_amount) AS tax_amount_sum
FROM orders;