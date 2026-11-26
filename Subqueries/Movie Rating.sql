WITH UserRank AS
(
    SELECT
        u.name,
        ROW_NUMBER() OVER (
            ORDER BY COUNT(*) DESC, u.name
        ) AS rn
    FROM Users u
    JOIN MovieRating mr ON mr.user_id = u.user_id
    GROUP BY u.user_id, u.name
),
MovieRank AS
(
    SELECT
        m.title,
        ROW_NUMBER() OVER (
            ORDER BY AVG(rating * 1.0) DESC, m.title
        ) AS rn
    FROM Movies m
    JOIN MovieRating mr ON mr.movie_id = m.movie_id
    WHERE created_at >= '2020-02-01'
      AND created_at < '2020-03-01'
    GROUP BY m.movie_id, m.title
)
SELECT name AS results FROM UserRank WHERE rn = 1
UNION ALL
SELECT title AS results FROM MovieRank WHERE rn = 1;