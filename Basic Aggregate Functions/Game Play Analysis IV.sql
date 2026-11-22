/*
    Approach 1: Clever query
*/

SELECT ISNULL(ROUND(SUM(a2.individualFraction), 2), 0.0) AS [fraction]
FROM Activity a1
JOIN 
(
    SELECT 
        player_id,
        MIN(event_date)        AS [login_date],
        1.0 / COUNT(1) OVER () AS [individualFraction]
    FROM Activity
    GROUP BY player_id
)a2 ON a2.player_id = a1.player_id AND a1.event_date = DATEADD(day, 1, a2.login_date)

/*
    Approach 2: Sophisticated Query - clear, efficient, and maintainable
*/
WITH FirstLogin AS
(
    SELECT
        player_id,
        MIN(event_date) AS login_date
    FROM Activity
    GROUP BY player_id
),
LoginCheck AS
(
    SELECT
        F.player_id,
        IIF(
            EXISTS (
                SELECT 1
                FROM Activity A
                WHERE A.player_id = F.player_id
                  AND A.event_date = DATEADD(DAY, 1, F.login_date)
            ),
            1.0,
            0.0
        ) AS NextDayLogin
    FROM FirstLogin F
)
SELECT
    ISNULL(ROUND(AVG(NextDayLogin), 2), 0.0) AS fraction
FROM LoginCheck;