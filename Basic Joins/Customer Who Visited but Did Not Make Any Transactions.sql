SELECT v.customer_id, COUNT(1) AS [count_no_trans]
FROM Visits v
WHERE v.visit_id NOT IN (SELECT DISTINCT t.visit_id FROM Transactions t) 
GROUP BY v.customer_id;