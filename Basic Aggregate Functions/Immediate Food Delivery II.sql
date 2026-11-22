SELECT 
    ROUND(AVG(IIF(firstOrder.date = d.customer_pref_delivery_date, 100.0, 0.0)), 2) AS[immediate_percentage]
FROM
(
    SELECT customer_id, MIN(order_date) AS [date]
    FROM Delivery 
    GROUP BY customer_id
)firstOrder
JOIN Delivery d ON d.customer_id = firstOrder.customer_id 
    AND d.order_date = firstOrder.date