#Задание № 2 SQL
#1.  Вывести список студентов, фамилии которых начинаются на букву «С».
select student_name, student_surname 
	from students 
    where student_name like "С%";
#2.  Вывести список студентов, в фамилии которых есть  «оу».
select student_name, student_surname 
	from students 
    where student_surname like "%оу%";
#3.  Вывести список студентов 34 группы, у которых есть телефон.
select student_name, student_surname, n_group, number_telephone 
	from students 
    where n_group = 34 and number_telephone is not null;
#4.  Вывести баллы  студентов  по каждому предмету. / Баллы рассчитываются оценка * 10./  №зачетки, Предмет, балл.
select n_zach, subject_name, mark*10 as bal 
	from students_subjects natural join teachers;
#5.  Получить список студентов 34 группы в алфавитном порядке.
select student_surname, student_name, n_group 
	from students 
    where n_group = 34 
    order by student_surname asc;
#6.  Упорядочить вывод 4 запроса по баллу.
select n_zach, subject_name, mark*10 as bal 
	from students_subjects natural join teachers
	order by bal asc;
#7.  Получить наивысший и наименьший балл, полученный студентами по Скандинавскиv рунам
select subject_name, max(mark*10) as max_bal, min(mark*10) as min_bal 
	from students_subjects natural join teachers;
#8.  Получить количество оценок 5, полученных студентами по ОБЖ.
select count(mark) as пятёрки_по_ОБЖ
	from (students_subjects natural join teachers) 
    where mark = 5 and subject_name = "ОБЖ"; 
#9.	 Получить среднее значение оценок по Вальгалловедению.
select avg(mark) as средняя_оценка_вальгалловедение 
	from (students_subjects natural join teachers)
	where subject_name = "Вальгалловедение";
#10. Вывести количество оценок, полученных каждым студентом. /предложение Group by/
select student_name, student_surname, count(mark) as marks 
	from students_subjects natural join students 
	group by (n_zach);
#11. Вывести список студентов со средними оценками, полученными студентами за сессию.  /не использовать Avg./
select student_name, student_surname, sum(mark) as s_mark, count(mark) as c_mark, sum(mark)/count(mark) as avg_mark
	from students_subjects natural join students group by (n_zach);
#12. Вывести для каждого предмета средний балл и количество оценок, полученных на экзамене.
select subject_name, avg(mark*10) as ср_балл, count(mark) as кол_во_оценок 
	from students_subjects natural join teachers group by (n_subject);
#13. Вывести количество оценок  «2», «3», «4», «5» полученных по каждому предмету. (3 способа: (Предмет, Оценка, Количество); 
#(Предмет, Количество 2, Количество 3, Количество 4, Количество 5) - двумя способами.)
select subject_name, mark, count(mark) 
	from students_subjects natural join teachers 
	group by subject_name, mark 
    order by subject_name, mark;

/*select subject_name, count2, count3, count4, count5 
	from teachers, 
		(select n_subject, count(mark) as count2 from students_subjects where mark = 2 group by n_subject) as ss2,  
        (select n_subject, count(mark) as count3 from students_subjects where mark = 3 group by n_subject) as ss3,
        (select n_subject, count(mark) as count4 from students_subjects where mark = 4 group by n_subject) as ss4,
        (select n_subject, count(mark) as count5 from students_subjects where mark = 5 group by n_subject) as ss5
    order by teachers.n_subject;*/
/*тут проблема с нулём, count не пишет 0 а потому, похоже, такой запрос не составить*/
#14. Вывести количество студентов в каждой группе.
#15. Вывести количество «2», «3», «4», «5», полученных каждым студентом на экзамене. (3 способа, см. запрос 13)
#16. Вывести количество человек в каждой группе, которые имеют телефон.
#17. Вывести количество студентов в каждой малочисленной группе. ( <5 человек)
#18. Вывести средний показатель успеваемости групп по предмету (N_группы, предмет, средний показатель успеваемости).
#19. Вывести сведения о трех студентах, получивших наибольшие баллы на экзамене по английскому языку.
