SELECT students.id, FName AS FirstName, LName AS LastName 
FROM students
JOIN(
SELECT *
FROM students_enroll_programs 
WHERE Term = "summer" AND id_from_Programs="BAg"
) tb2
ON tb2.id_from_Students = students.id;
