USE om;

SELECT o.order_id, 
	   o.item_id,
       o.order_qty,
       i.title,
       i.artist,
       i.unit_price 
FROM order_details o
JOIN items i USING(item_id)
ORDER BY unit_price DESC;