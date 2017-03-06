# 1 Построить запрос кот. выводит декартово произведение двух таблиц Студенты и Предметы.
select * from students, teachers;

# 2 Построить запрос кот. выводит фамилию студента вместе с названиями предметов и оценками, кот. были им получены
select student_surname, subject_name, mark from students natural join teachers natural join students_teachers 
	order by student_surname;

# 3 Напишите запрос который вывел бы фамилии студентов вместе с названиями предметов, 
# сданных в сессию  и фамилиями преподавателей.
select student_surname, subject_name, teacher_name, mark 
	from students natural join teachers natural join students_subjects;

# 4 Вывести фамилии преподавателей, названия предметов и группы, у кот. принимал экзамен данный преподаватель
select teacher_name, subject_name, n_group 
	from teachers natural join students natural join students_subjects 
	order by teacher_name;

# 5 Вывести список студентов из той же группы, что и Гвюднадоуттир
select * from students where n_group in 
	(select n_group from students where student_surname = "Гвюднадоуттир");

# 6 Вывести список преподавателей, кот. ведут тот же предмет, что и преподаватель Бурков.
select teacher_name, subject_name from teachers
	where subject_name in (select subject_name from teachers where teacher_name like "Точная%")
	and teacher_name not like "Точная%";

# 7 Вывести количество студентов, сдавших экзамены  по каждому предмету.(использовать группировку)	
select count(n_zach) as количество_сдавших, subject_name 
	from students natural join students_subjects natural join teachers
	where mark > 2 group by subject_name;

# 8 Вывести количество оценок 2, 3, 4, 5 полученных в каждой группе. (использовать группировку)
select n_group, mark, count(mark)
	from students natural join students_subjects 
    group by n_group, mark ;

# 9 Вывести  средний балл оценок, полученных в каждой группе. (использовать группировку)
select n_group, avg(mark) from students natural join students_subjects group by n_group;

# 10 Вывести количество оценок 2, 3, 4, 5 по каждому предмету вместе с преподавателем,
# кот. принимал экзамен. (использовать группировку)
select subject_name, teacher_name, mark, count(mark)
	from students_subjects natural join teachers 
    group by subject_name, teacher_name, mark;

# 11 Вывести фамилии студентов, названия предметов, оценки, и фамилии преподавателей,
# кот. принимали экзамен у данного студента по данному предмету.
select student_surname, subject_name, mark, teacher_name 
	from students natural join students_subjects natural join teachers;

# 12 Вывести список «слабых» групп, средний балл по оценкам которых ниже 4.
select n_group, avg(mark) from students natural join students_subjects 
	group by n_group having avg(mark)<4;

# 13 Вывести список студентов, средний балл которых не ниже 4.
select n_zach, student_surname, avg(mark) from students natural join students_subjects 
	group by n_zach having avg(mark) >=4 ;

# 14 Узнать успеваемость студентки Weimann по всем предметам (написать 2 запроса: 
# использующий соединение и использующий подзапрос) 
select student_surname, subject_name, mark
	from students natural join students_subjects natural join teachers
	where student_surname = "Weimann";

select "Weimann" as фамилия, subject_name, mark from students_subjects, teachers
	where students_subjects.n_subject = teachers.n_subject
    and n_zach = (select n_zach from students where student_surname="Weimann");

# 15 Вывести список групп, у кот. принимал экзамен Невероятный Владислав Мартьянович. 
# (написать 2 запроса: использующий соединение и использующий подзапрос)
select n_group from students natural join students_subjects natural join teachers
	where teacher_name = "Невероятный Владислав Мартьянович" group by n_group;

select n_group from students where n_zach in
	(select n_zach from students_subjects where n_subject in
		(select n_subject from teachers where teacher_name = "Невероятный Владислав Мартьянович"))
	group by n_group;

# 16 Вывести список предметов, кот. сдавала студентка Weimann. (написать 2 запроса:
# использующий соединение и использующий подзапрос)
select "Weimann", subject_name, n_subject from students natural join students_subjects natural join teachers
	where student_surname = "Weimann";

select "Weimann", subject_name, n_subject from teachers where n_subject in
	(select n_subject from students_subjects where n_zach =
		(select n_zach from students where student_surname = "Weimann" limit 1));

# 17 Вывести список студентов, успеваемость кот. выше чем у студентки
# Weimann. (т.е. средний балл выше, чем средний балл студентки Weimann). /подзапрос в предложении Having/.
select n_zach, student_surname, avg(mark) from students natural join students_subjects
	group by n_zach
		having avg(mark) > (select avg(mark) from students_subjects where n_zach = 
			(select n_zach from students where student_surname = "Weimann"));

# 18 Узнать по каким предметам самая низкая успеваемость. /подзапрос в предложении Having/.
select n_subject, subject_name, avg(mark) from teachers natural join students_subjects
	group by n_subject having avg(mark) < 3.5;

# 19 Узнать № «сильных» групп (с успеваемостью выше средней) /подзапрос в предложении Having/.
select n_group, avg(mark) from students natural join students_subjects
	group by n_group having avg(mark) > (select avg(mark) from students_subjects) 
    order by avg(mark);