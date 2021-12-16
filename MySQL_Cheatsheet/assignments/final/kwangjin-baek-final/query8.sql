USE swexpert;

	SELECT e_id AS 'evaluation_id',
		   e_date AS 'evaluation_date',
		   score AS 'evaluation_score',
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
ORDER BY 3;