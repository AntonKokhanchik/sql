# Напишите запрос, который вывел бы фамилии студентов.
select student_surname from students;
# Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: №группы, имя, фамилию, телефон.
select n_group, student_name, student_surname, number_telephone from students;
# Напишите запрос, который вывел бы всю информацию из таблицы.
select * from students;
# Напишите запрос который вывел бы все строки из таблицы «Студенты», для которых номер группы = 34.
select * from students where n_group=34;
# Напишите запрос, который вывел бы записи о студенте «Йоунссон».
select * from students where student_surname="Йоунссон";
# Напишите запрос, который вывел бы записи о студентах с именем «Сигридюр»
select * from students where student_name="Сигридюр";
# Напишите запрос, который вывел бы записи о студентах 44 и 45 группы.
select * from students where n_group=44 or n_group=45;
# Напишите запрос, который вывел бы записи о студентах  34 и 35 группы, которые имеют телефон
select * from students 
	where n_group=34 or n_group=35 and number_telephone is not null;
# Напишите запрос, который вывел бы значения № группы из таблицы «Студенты», без каких бы то ни было  повторений.
select distinct n_group from students order by n_group asc;
# Напишите запрос, который вывел бы фамилии преподавателей. /Учесть, чтобы фамилии появлялись без повтора, если преподаватели ведут два и более предметов/
select distinct teacher_name from teachers;
# Вывести №зачеток неуспевающих студентов.
select n_zach from students 
	where n_zach in 
		(select n_zach from students_subjects where mark = 2);
# Напишите запрос, который вывел бы информацию о сдаче экзаменов студентом №зачетки кот.= 7443
select n_zach, student_name, student_surname, subject_name, mark 
	from students_subjects natural join students natural join teachers
    where n_zach = 7443;
# Напишите запрос который вывел бы № зачеток студентов, которые сдали скандинавские руны на хорошо и отлично.
select n_zach from students_subjects 
	where n_subject in 
		(select n_subject from teachers where subject_name="Скандинавские руны") 
	and (mark = 4 or mark = 5);
# Напишите запрос, который вывел бы информацию о сдаче экзаменов студентами  №зачетки кот.= 7443, 5211, 7141. /написать 2 варианта/
select n_zach, student_name, student_surname, subject_name, mark 
	from students_subjects natural join students natural join teachers 
    where n_zach = 7443 or n_zach = 5211 or n_zach=7141;

# Напишите запрос, который вывел бы информацию об оценке по метанию топоров, полученной студентами  №зачетки кот.= 8970, 5211, 7141. /написать 2 варианта/
select n_zach, mark from students_subjects 
	where n_subject in 
		(select n_subject from teachers where subject_name="Метание топоров") 
	and	(n_zach = 8970 or n_zach = 5211 or n_zach=7141);
    
select n_zach, student_name, student_surname, subject_name, mark 
	from students_subjects natural join students natural join teachers 
    where (n_zach = 8970 or n_zach = 5211 or n_zach=7141) 
    and subject_name="Метание топоров";