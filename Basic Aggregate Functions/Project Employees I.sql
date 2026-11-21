SELECT p.project_id, ROUND(AVG(CAST(e.experience_years AS DECIMAL)), 2) AS [average_years]
FROM Project p
JOIN Employee e ON e.employee_id = p.employee_id
GROUP BY p.project_id;