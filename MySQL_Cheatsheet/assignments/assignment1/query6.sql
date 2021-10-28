SELECT order_id, order_date, ship_date 
FROM orders
WHERE ship_date IS NULL;