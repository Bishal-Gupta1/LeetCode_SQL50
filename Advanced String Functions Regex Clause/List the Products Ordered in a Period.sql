SELECT 
    (SELECT product_name FROM Products WHERE product_id = o.product_id) AS [product_name],
    o.unit 
FROM
(
    SELECT 
        product_id, 
        SUM(IIF(order_date >= '2020-02-01' AND order_date < '2020-03-01', unit, 0)) AS [unit]
    FROM Orders
    GROUP BY product_id
)o
WHERE o.unit >= 100;