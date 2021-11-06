USE swexpert;

    SELECT p_id, project_name 
	FROM project
	WHERE p_id IN (
		SELECT p_id FROM project_consultant
		WHERE c_id = (
			SELECT c_id FROM consultant
			WHERE c_last LIKE 'Z%'))
UNION
	SELECT p_id, project_name FROM project
	WHERE p_id IN (SELECT p_id FROM evaluation);   