SELECT s1.id, ISNULL(s2.student, s1.student) AS [student]
FROM Seat s1
LEFT JOIN Seat s2 ON s2.id = (IIF((s1.id & 1) = 1, s1.id + 1 , s1.id - 1))
ORDER BY s1.id;