SELECT 
    contest_id,
    ROUND(COUNT(1) * (SELECT (100.0 / COUNT(user_id)) FROM Users), 2) AS [percentage]
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id;