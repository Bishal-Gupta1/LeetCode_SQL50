SELECT name, bonus
FROM Employee e
LEFT JOIN Bonus b ON b.empID = e.empID
WHERE ISNULL(bonus, 999) < 1000 ;