SELECT id_From_students AS student, id_from_Courses_from_Sections AS courses
FROM students_registered_sections
WHERE term = "summer" AND id_From_students = "19991122";
