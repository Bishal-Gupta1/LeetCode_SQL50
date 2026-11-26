SELECT visited_on, amount, average_amount
FROM
(
    SELECT 
        visited_on, 
        SUM(amount) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS [amount],
        ROUND(
            AVG(amount * 1.0) OVER (
                ORDER BY visited_on 
                ROWS BETWEEN 6 PRECEDING AND CURRENT ROW 
            ), 2) AS [average_amount],
        ROW_NUMBER() OVER (
            ORDER BY visited_on
        )AS [rn]
    FROM
    (
        SELECT visited_on, SUM(amount) AS [amount]
        FROM Customer
        GROUP BY visited_on
    )data1
  )data2   
  WHERE rn >= 7;