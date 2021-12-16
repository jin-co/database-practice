USE swexpert;

SELECT skill_description,
       c_first,
       c_last
FROM consultant 
	JOIN consultant_skill USING(c_id)
    JOIN skill USING(skill_id)
WHERE certification = 'Y';