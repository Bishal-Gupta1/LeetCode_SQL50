SELECT 
    employee_id, 
    name,
    e2.reports_count,
    e2.average_age
FROM Employees e1
JOIN 
(
    SELECT
        reports_to,  
        COUNT(1) AS [reports_count],
        ROUND(AVG(age * 1.0), 0) AS [average_age]
    FROM Employees
    GROUP BY reports_to
)e2 ON e2.reports_to = e1.employee_id 
