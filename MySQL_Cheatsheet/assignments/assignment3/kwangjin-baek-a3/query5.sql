USE swexpert;

-- insert
INSERT INTO project(
			p_id, project_name, client_id,
            mgr_id, parent_p_id)
       VALUES(
			88, "ION Rapid Transit", 17,
            106, NULL);
            
-- select
SELECT * FROM project;