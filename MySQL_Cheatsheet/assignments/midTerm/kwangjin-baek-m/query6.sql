USE ex;	

SELECT e.employee_ID,
	   e.first_name,
       e.last_name,
       p.project_number
FROM employees e
LEFT JOIN projects p USING(employee_id)
WHERE p.project_number IS NULL;