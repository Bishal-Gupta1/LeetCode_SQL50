/*
Approach 1: using Self Join
*/
SELECT DISTINCT L1.num AS [ConsecutiveNums]
FROM Logs L1
JOIN Logs L2 ON (L1.id = L2.id + 1 AND L1.num = L2.num)
JOIN Logs L3 ON (L3.id = L2.id + 2 AND L1.num = L3.num)

/*
Approach 2: using LEAD window function
*/
SELECT DISTINCT ConsecutiveNums
FROM 
(
    SELECT 
        num AS [ConsecutiveNums], 
        IIF (num = LEAD(num, 1) OVER (ORDER BY id) AND num = LEAD(num, 2) OVER (ORDER BY id), 1, 0) AS [isCons]   
    FROM Logs
)l
WHERE l.isCons = 1; 