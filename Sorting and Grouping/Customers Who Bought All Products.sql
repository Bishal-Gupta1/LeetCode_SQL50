DECLARE @productCount INT = (SELECT COUNT(1) FROM Product);

SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) =  @productCount;