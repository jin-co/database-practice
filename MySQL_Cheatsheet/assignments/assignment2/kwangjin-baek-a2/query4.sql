SELECT last_name, 
	   first_name, 
	   order_date, 
	   product_name, 
	   item_price, 
	   discount_amount, 
	   quantity
FROM Customers c 
	JOIN Orders o USING(customer_id)
    JOIN Order_Items oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
ORDER BY last_name, order_date, product_name;