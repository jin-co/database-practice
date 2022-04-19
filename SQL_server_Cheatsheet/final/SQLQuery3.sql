

CREATE VIEW vw_order_email AS
SELECT firstName, lastName FROM orders
WHERE email LIKE '%conestogac.on.ca';