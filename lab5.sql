# 1 Вывести список групп, в которых учится студент "Collier". (2 запроса: с исп. Exists и Any)

select n_group from students as st1 where exists
		(select * from students where students.n_group = st1.n_group and student_surname = "Collier") 
	group by n_group;

select n_group from students where n_zach = 
	any (select n_zach from students where student_surname = "Collier");

# 2 Вывести список студентов /фамилия, №группы, ср. оценка/, 
# средняя оценка которых больше чем хотя бы у одного студента по фамилии Collier.(2 запроса)
select student_surname, n_group, avg(mark) from students_subjects natural join students where student_surname != "Collier" 
	group by n_zach
	having avg(mark) > any
		(select avg(mark) from students natural join students_subjects where student_surname = "Collier" group by n_zach);

select student_surname, n_group, avg(mark) from students_subjects natural join students as s1
	where exists (select avg(mark) from students_subjects where students_subjects.n_zach = s1.n_zach 
		having avg(mark) > (select avg(mark) from students natural join students_subjects where student_surname = "Collier")) 
	and student_surname != "Collier" group by n_zach;

# 3 Вывести список студентов /фамилия, №группы, ср. оценка/, 
# средняя оценка которых больше чем  у всех студентов по фамилии Collier.(2 запроса)
select student_surname, n_group, avg(mark) from students_subjects natural join students
	group by n_zach having avg(mark) > (select max(f1) from 
		(select avg(mark) as f1 from students natural join students_subjects where student_surname = "Collier" 
        group by n_zach) as t1);

select student_surname, n_group, avg(mark) from students_subjects as ss1 natural join students where exists
		(select * from students_subjects as ss2 where ss1.n_zach = ss2.n_zach group by n_zach 
		having avg(mark) > (select max(str1) from 
			(select avg(mark) as str1 from students natural join students_subjects 
				where student_surname = "Collier" group by n_zach) as t1)) group by n_zach;

# 4 Вывести фамилию, №группы и оценку за экзамен по Языки тех студентов, 
# кот. сдали этот экзамен лучше, чем все студенты по фамилии Collier.(2 запроса)
select student_surname, n_group, mark 
	from students_subjects natural join students natural join teachers 
    where subject_name = "Языки"
	group by n_zach having mark > (select max(m) 
		from (select mark as m from students natural join students_subjects  natural join teachers 
			where student_surname = "Collier" and subject_name = "Языки" group by n_zach) as t);

select student_surname, n_group, mark 
	from students_subjects natural join students natural join teachers 
	where subject_name = "Языки" and mark > (select max(m) from 
			(select mark as m from students natural join students_subjects  natural join teachers
			where student_surname = "Collier" and subject_name = "Языки" group by n_zach) as t);

# 5 Вывести в алфавитном порядке в одном столбце фамилии, имена и отчества студентов и преподавателей.
(select concat(student_surname, " ",  student_name, " ",  student_lastname) as ФИО from students)
union (select concat(teacher_name) as ФИО from teachers) 
order by ФИО;

# 6 Вывести весь список 44 группы, если в ней учится студент Collier. (написать 3 типа запроса)
select n_zach, student_surname from students as t1 where n_group = 44 and exists
	(select * from students as t2 where t1.n_group = t2.n_group and student_surname = "Collier");

select n_zach, student_surname from students where n_group = 
	(select n_group from students where student_surname = "Collier" and n_group = 44) order by n_zach;

select n_zach, student_surname from students as t1 where 
	if(n_group = 
		(select n_group from students as t2 where student_surname = "Collier" and n_group = 44),
	true, false);

# 7 Используя объединение Union подготовить данные для ведомости на стипендию: 
# одна 5, остальные – 4 – 1200 руб., все 5 – 1400 руб.

select n_zach, student_surname, 1200 as стипендия 
	from students natural join students_subjects  group by n_zach 
	having sum(mark = 5) = 1 and sum(mark = 3) + sum(mark =2) = 0
union select n_zach, student_surname, 1400 as стипендия 
	from students natural join students_subjects  group by n_zach 
	having sum(mark=5) > 0 and sum(mark = 3) + sum(mark =2) + sum(mark =4) = 0;