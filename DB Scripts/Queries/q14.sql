SELECT id_from_Students_from_Graduates AS id, FName, LName
FROM thesis_students,students
WHERE id_from_Supervisors = 0
AND students.id = id_from_Students_from_Graduates;
