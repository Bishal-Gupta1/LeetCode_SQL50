SELECT ROUND(SUM(i.tiv_2016), 2) AS [tiv_2016]
FROM Insurance i
JOIN
(
    SELECT lat, lon FROM Insurance GROUP BY lat, lon HAVING COUNT(*) = 1
)addr ON addr.lat = i.lat AND addr.lon = i.lon
JOIN
(
    SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1
)freq ON freq.tiv_2015 = i.tiv_2015