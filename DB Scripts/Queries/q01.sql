INSERT INTO instructors VALUES ('993', 'kaidi@email.com', 'Kaidi', 'Instr', '123456789', '5147866655', '000', '0000', 'Park ave', 'Laval', 'J6R2X8', 'Quebec', 'ENCS'
);

DELETE
FROM instructors
WHERE id= 993;

update instructors
set Lname = "Guo"
where id = 993;

SELECT *
FROM instructors
WHERE id = 993;
