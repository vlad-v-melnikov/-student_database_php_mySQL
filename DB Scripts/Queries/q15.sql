SELECT id, fname,lname,assignment
FROM(
	(SELECT Assignment_Type AS Assignment, id_from_Students_from_Graduates_from_TAs
	FROM log_of_tas
	WHERE id_from_Courses ="Math 101" AND Term = "winter") tb1
	join students
	on students.id =id_from_Students_from_Graduates_from_TAs
    );
