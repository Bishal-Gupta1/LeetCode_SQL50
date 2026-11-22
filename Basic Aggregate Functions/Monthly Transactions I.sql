SELECT
    month, 
    country,
    COUNT(1)                              AS [trans_count],
    SUM(IIF(state='approved', 1, 0))      AS [approved_count],
    SUM(amount)                           AS [trans_total_amount],
    SUM(IIF(state='approved', amount, 0)) AS [approved_total_amount]
FROM Transactions 
OUTER APPLY 
(
    SELECT FORMAT(trans_date, 'yyyy-MM') AS [month]
)data
GROUP BY month, country;