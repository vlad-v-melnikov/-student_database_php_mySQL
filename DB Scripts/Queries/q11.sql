SELECT instructors.id, FName AS FirstName, LName AS LastName, course,term 
FROM instructors
JOIN(
SELECT id_from_instructors, id_from_Courses_from_Sections as course, Term
FROM log_of_instructors
WHERE id_from_Courses_from_Sections = "Math 101" AND Term ="Summer"
) tb2
ON tb2.id_from_instructors = instructors.id;
