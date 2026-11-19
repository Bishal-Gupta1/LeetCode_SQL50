-- Approach 1: Self Join
SELECT w2.id
FROM Weather w1
JOIN (SELECT id, DATEADD(day, -1, recordDate) AS [nextDay], temperature FROM Weather)w2 
    ON w2.nextDay = w1.recordDate AND w1.temperature < w2.temperature;

--Approach 2: using LAG window function
SELECT id
FROM
(
    SELECT 
        id,
        recordDate, 
        temperature,
        LAG(DATEADD(day, 1, recordDate), 1) OVER (ORDER BY recordDate) AS [nextDay],
        LAG(temperature, 1) OVER (ORDER BY recordDate) AS [prevDayTemp]
    FROM Weather
)temp 
WHERE  recordDate = nextDay AND temperature > prevDayTemp;