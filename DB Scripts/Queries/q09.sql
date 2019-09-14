SELECT department, tb1.course, tb2.section,Start_Time,End_Time,room, capacity, instructorId,FName, LName,Enrolled
FROM(
	SELECT p.id_from_departments AS department,l.id_from_courses AS course
	FROM log_of_courses l
	JOIN programs p
	ON p.id = l.id_from_Programs
	WHERE l.term = "summer"
	AND p.id_from_departments="JMSB") tb1
JOIN (
	SELECT id AS section, Start_Time, End_Time, id_from_rooms AS room,id_from_courses AS course
	FROM sections
    ) tb2
ON tb1.course = tb2.course
JOIN (
	SELECT id_from_sections AS section, id_from_Courses_from_Sections AS course,id_from_Instructors AS instructorId
    FROM log_of_instructors
    ) tb3
ON tb2.section = tb3.section AND tb2.course = tb3.course
JOIN(
	SELECT id, FName, LName
    FROM instructors
	)tb4
ON tb3.instructorId = tb4.id
JOIN(
	SELECT id, capacity
    FROM rooms
	)tb5
ON tb2.room = tb5.id
JOIN(
	SELECT id_from_sections AS section, id_from_Courses_from_Sections AS course, count(id_from_Students) AS Enrolled
    FROM students_registered_sections
    WHERE Term = "summer"
    GROUP BY section, course
)tb6
ON tb2.section = tb6.section AND tb2.course = tb6.course;
