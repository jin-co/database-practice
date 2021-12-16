USE my_guitar_shop;

INSERT INTO orders VALUES(
	DEFAULT,
    4,
    SYSDATE(),
    15,
    5,
    NULL,
    42.56,
    'Visa',
    '1234567891234567',
    '12/2021',
    5
);
SELECT * FROM orders;