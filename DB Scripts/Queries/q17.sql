SELECT departments.name, departments.chairman, count(courses.id)
FROM departments 
LEFT JOIN programs ON departments.id = programs.id_from_Departments
left JOIN courses ON courses.id_from_programs = programs.id
GROUP BY departments.name;
