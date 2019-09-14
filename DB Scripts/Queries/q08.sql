SELECT id_from_courses AS course, id_from_programs AS program
FROM log_of_courses
WHERE id_from_programs = "AMb" AND term = "summer";
