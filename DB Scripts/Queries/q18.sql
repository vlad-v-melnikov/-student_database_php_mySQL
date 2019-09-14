SELECT tb1.id AS program, count(id_from_Students) AS "students enrolled"
FROM (
	(SELECT programs.id
    FROM programs) tb1
    LEFT JOIN (
		SELECT *
        FROM students_enroll_programs s
        WHERE year="2018"AND term="SUMMER"
    )tb2
    ON tb1.id = tb2.id_from_Programs
)
GROUP BY tb1.id;
