USE my_guitar_shop;

SELECT item_id,
       product_id,
       item_price,
       quantity 
FROM order_items
WHERE item_price > 400 AND item_price < 1200
ORDER BY item_price DESC;