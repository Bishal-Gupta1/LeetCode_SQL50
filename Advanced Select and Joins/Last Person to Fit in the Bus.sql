SELECT TOP 1 person_name
FROM 
(
    SELECT 
        turn,
        person_name, 
        SUM(weight) OVER (ORDER BY turn) AS [TotalWeight] 
    FROM Queue 
)q
WHERE TotalWeight <= 1000
ORDER BY turn DESC;