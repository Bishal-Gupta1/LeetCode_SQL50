SELECT *
FROM Users
WHERE mail LIKE '%@leetcode.com' COLLATE Latin1_General_CS_AS
AND mail LIKE '[A-Za-z]%'
AND LEFT(mail, LEN(mail) - 13) NOT LIKE '%[^0-9a-zA-Z-_.]%'