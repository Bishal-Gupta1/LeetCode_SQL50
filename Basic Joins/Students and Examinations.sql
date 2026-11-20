SELECT s.student_id,  s.student_name, sb.subject_name, ISNULL(se.attended_exams, 0) AS [attended_exams]
FROM Students s
CROSS JOIN Subjects sb
LEFT JOIN
(
    SELECT student_id, subject_name, COUNT(subject_name) AS [attended_exams]
    FROM Examinations
    GROUP BY student_id, subject_name
)se ON se.student_id = s.student_id AND se.subject_name = sb.subject_name
ORDER BY s.student_id, sb.subject_name;