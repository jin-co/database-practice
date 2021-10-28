USE swexpert;

-- insert
INSERT INTO client(
			client_id, client_name, contact_last,
            contact_first, contact_phone)
       VALUES(
			17, "City of Waterloo", "Jaworsky",
            "Dave", "519 886 1550");
            
-- select
SELECT * FROM client;