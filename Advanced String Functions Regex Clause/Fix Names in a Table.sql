--Approach 1: using STUFF
SELECT user_id, STUFF(LOWER(name), 1, 1, UPPER(LEFT(name, 1))) AS [name]
FROM Users
ORDER BY user_id;

-- Approach 2: concating parts
SELECT user_id, UPPER(LEFT(name, 1)) + LOWER(SUBSTRING(name, 2, LEN(name))) AS [name]
FROM Users
ORDER BY user_id;