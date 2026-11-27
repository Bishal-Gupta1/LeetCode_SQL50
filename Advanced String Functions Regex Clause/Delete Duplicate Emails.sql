BEGIN TRANSACTION;

WITH Duplicates AS
(
    SELECT *, ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn FROM Person
)
DELETE FROM Duplicates
WHERE rn > 1;

COMMIT;

/*
==========================================
CTE and DELETE in SQL Server: Key Takeaways
==========================================

1. CTE (Common Table Expression) is a named query expression, NOT a physical or temporary table.

2. A CTE exists only for the single SQL statement immediately following its definition.

3. SQL Server allows DELETE directly from an  updatable CTE.

4. DELETE FROM CTE deletes records from the actual underlying base table, not a separate copy.

5. A CTE does not create an independent copy  of the underlying data.

6. JOIN can be used inside a CTE to identify records that need to be deleted.

7. A joined CTE may be updatable, provided SQL Server can unambiguously identify the target table.

8. GROUP BY, DISTINCT, aggregate functions and set operators generally prevent direct DELETE through a CTE.

9. When deleting using multiple joined tables, explicitly specifying the DELETE target is safer and clearer.

------------------------------------------
RECOMMENDED APPROACH: DELETE WITH JOIN
------------------------------------------

DELETE E
FROM Employees E
INNER JOIN Departments D ON E.dept_id = D.dept_id
WHERE D.dept_name = 'XYZ';

------------------------------------------
IMPORTANT DISTINCTIONS
------------------------------------------

DELETE FROM CTE       -- Deletes from underlying
                         base table if updatable.

DELETE FROM #Temp     -- Deletes from temporary
                         table only.

DELETE E FROM ...     -- Explicitly targets
                         Employees table.

------------------------------------------
GOLDEN RULE
------------------------------------------

JOIN determines WHICH rows qualify for deletion.
DELETE determines WHICH table loses those rows.

==========================================
*/