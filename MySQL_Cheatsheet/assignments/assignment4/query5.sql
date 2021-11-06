USE swexpert;

SELECT ROUND(AVG(score), 1) AS score_avg
FROM evaluation
WHERE evaluatee_id = 105;