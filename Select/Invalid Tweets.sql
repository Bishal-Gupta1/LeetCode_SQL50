SELECT tweet_id
FROM Tweets
WHERE LEN(content) > 15

/* Another approach to the same query is to use a subquery. The following query will return the same result as the previous one:

SELECT data.tweet_id
FROM (SELECT tweet_id, LEN(content) AS [conLen] FROM Tweets) data
WHERE data.conLen > 15

*/