SELECT FName, LName
FROM advisors
JOIN programs
on advisors.id_from_programs = programs.id
WHERE programs.id_from_departments ="ENCS";
