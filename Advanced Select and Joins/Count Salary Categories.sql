--Approach 1: Using UNION
SELECT 'Low Salary' AS [category], SUM(IIF(income < 20000, 1, 0)) AS [accounts_count] FROM Accounts 
UNION
SELECT 'Average Salary' AS [category], SUM(IIF(income BETWEEN 20000 AND 50000, 1, 0)) AS [accounts_count] FROM Accounts 
UNION
SELECT 'High Salary' AS [category], SUM(IIF(income > 50000, 1, 0)) AS [accounts_count] FROM Accounts

--Apporach 2: Using CROSS APPLY
SELECT v.category, v.accounts_count
FROM
(
    SELECT
        COUNT(CASE WHEN income < 20000 THEN 1 END) AS [Low Salary],
        COUNT(CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 END) AS [Average Salary],
        COUNT(CASE WHEN income > 50000 THEN 1 END) AS [High Salary]
    FROM Accounts
) AS c
CROSS APPLY
(
    VALUES
        ('Low Salary', c.[Low Salary]),
        ('Average Salary', c.[Average Salary]),
        ('High Salary', c.[High Salary])
) AS v(category, accounts_count);


--Apporach 3: Using PIVOT/UNPIVOT
SELECT category, accounts_count
FROM      
(
    SELECT [Low Salary], [Average Salary], [High Salary]
    FROM
    (
        SELECT
            account_id,
            CASE 
                WHEN income < 20000 THEN 'Low Salary'
                WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
                ELSE 'High Salary'
            END AS [SalCategory]
        FROM Accounts
    )data1
    PIVOT
    (
        COUNT(account_id)
        FOR SalCategory IN ([Low Salary], [Average Salary], [High Salary])
    )pvt1
)data2
UNPIVOT
(
    accounts_count 
    FOR category IN ([Low Salary], [Average Salary], [High Salary])
)pvt2
