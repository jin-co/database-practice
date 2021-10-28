USE swexpert;

-- insert
INSERT INTO consultant(
			c_id, c_last, c_first, c_mi,
            c_add, c_city, c_state, c_zip,
			c_phone, c_email)
       VALUES(
			106, "Baek", "Kwangjin", "K",
            "1234 Broadway", "Hermagor", "AA", "12345",
            "1234567890", "gogo@go.com");

-- select
SELECT * FROM consultant;            