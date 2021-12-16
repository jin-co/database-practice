USE my_guitar_shop;

SELECT c.last_name,
       c.first_name, 
       o.order_date, 
       p.product_name, 
       oi.item_price, 
       oi.quantity, 
       o.ship_date
FROM customers c
	JOIN orders o USING(customer_id)
    JOIN order_items oi USING(order_id)
    JOIN products p USING(product_id)
ORDER BY order_date, product_name;