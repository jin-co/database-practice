USE swexpert;

-- update
UPDATE project SET parent_p_id = 88
WHERE parent_p_id IS NULL AND p_id <> 88;

-- select
SELECT * FROM project;