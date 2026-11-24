SELECT x, y, z, IIF(X+y > z AND x+z > y AND y+z > x, 'Yes', 'No') AS [triangle]
FROM Triangle