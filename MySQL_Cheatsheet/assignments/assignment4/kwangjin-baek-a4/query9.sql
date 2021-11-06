USE swexpert;

ALTER TABLE project_consultant
ADD COLUMN total_days INT DEFAULT(0);

SET SQL_SAFE_UPDATES = 0;

UPDATE project_consultant SET total_days = roll_off_date - roll_on_date;

SELECT * FROM project_consultant;

ALTER TABLE project_consultant
DROP COLUMN total_days;