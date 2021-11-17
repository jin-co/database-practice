USE swexpert;

SELECT CONCAT_WS(' ', c_first, c_last) AS full_name,
       (SELECT ROUND(AVG(score), 2) FROM evaluation
        WHERE evaluatee_id = c.c_id) AS e_score_avg
FROM consultant c
WHERE CONCAT_WS(' ', c_first, c_last) = 'Janet Park';