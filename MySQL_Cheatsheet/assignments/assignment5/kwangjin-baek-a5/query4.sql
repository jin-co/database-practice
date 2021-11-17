USE swexpert;

SELECT LPAD(p_id, LENGTH('project_id') + 3, ' ') AS project_id,
       LPAD(c_id, LENGTH('consultant_id') + 3, ' ') AS consultant_id,       
       LPAD(TRUNCATE(DATEDIFF(roll_off_date, roll_on_date) / 30.4, 0), 
			LENGTH('months'), '*') AS months
FROM project_consultant;