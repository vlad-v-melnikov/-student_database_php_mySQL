SELECT Fname,Lname, Amount
From thesis_students, research_funding, students
where thesis_students.id_from_Research_Funding =research_funding.id
AND students.id = thesis_students.id_from_Students_from_Graduates
AND research_funding.term = "summer";
