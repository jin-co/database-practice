USE swexpert;

	SELECT e_id,
		   e_date,
		   score,
		   'EXCELLENT' AS 'grade'
	FROM evaluation
	WHERE score > 90
UNION
	SELECT e_id,
		   e_date,
		   score,
		   'GOOD'
	FROM evaluation
	WHERE score BETWEEN 80 AND 90
UNION
	SELECT e_id,
		   e_date,
		   score,
		   'FAIL'
	FROM evaluation
	WHERE score < 80
ORDER BY score;