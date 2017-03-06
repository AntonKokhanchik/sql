# 1	Вывести фамилии преподавателей, которые принимали экзамен (2 способа: использовать exists и соединение)
select distinct teacher_name from teachers right join students_subjects 
	on students_subjects.n_subject = teachers.n_subject;

select distinct teacher_name from teachers where exists 
	(select * from students_subjects where students_subjects.n_subject = teachers.n_subject);

# 2	Список студентов, сдавших хотя бы один экзамен на 5 (2 способа: использовать exists и соединение)
select distinct student_name, student_surname from students natural join students_subjects where (mark = 5);

select distinct student_name, student_surname from students where exists 
	(select * from students_subjects where mark = 5 and students_subjects.n_zach = students.n_zach);

# 3	Список студентов, сдавших больше 1 экзамена (2 способа: использовать вложенный запрос и группировку)
select distinct student_name, student_surname from students
	where (n_zach in (select n_zach from students_subjects group by n_zach having count(n_subject)>1));
    
select distinct student_name, student_surname from students
	where exists (select n_zach from students_subjects where students_subjects.n_zach = students.n_zach having count(n_subject)>1);

# 4	Список студентов, не сдававших ни одного экзамена (написать 2 запроса)
select distinct student_name, student_surname from students where (n_zach not in 
	(select distinct n_zach from students_subjects));
    
select distinct student_name, student_surname from students
	where not exists (select n_zach from students_subjects where students_subjects.n_zach = students.n_zach);

# 5	Вывести предметы, по которым данный студент хорошо сдал экзамены (т.е. оценка по которым лучше его среднего балла). Вывести №зачетки, предмет и оценку.
select n_zach, subject_name, mark from students_subjects ss1 natural join teachers
	where mark > (select avg(mark) from students_subjects ss2 where ss1.n_zach=ss2.n_zach group by n_zach)
    group by n_zach, n_subject
    order by n_zach, subject_name, mark desc;
    
# 6	Вывести фамилии студентов, кот. сдавали экзамен (предмет, оценку и фамилию экзаменатора).
#		Написать 2 типа запроса: использовать соединение и вложенный запрос в предложении Select.
select subject_name, teacher_name, student_surname, mark from teachers natural join students_subjects natural join students;
    
select (select subject_name from teachers t1 where t1.n_subject=t0.n_subject) as subj,
	   (select teacher_name from teachers t2 where t2.n_subject=t0.n_subject) as teacher,
	   (select student_surname from students t3 where t3.n_zach = t0.n_zach) as student,
       mark from students_subjects t0;
    
# 7	Вывести информацию о студентах, у кот. принимал экзамен Любомир Платонович Вояковский.
#		Вывести № зачетки, предмет и оценку (написать 2 запроса, один с использованием предиката Exists).
select n_zach, subject_name, mark from students_subjects natural join teachers
	where subject_name in (select subject_name from teachers where teacher_name = "Любомир Платонович Вояковский");
    
select n_zach, subject_name, mark from students_subjects t1, teachers t2 where exists 
	(select n_subject from teachers t where teacher_name = "Любомир Платонович Вояковский"
		and t1.n_subject = t2.n_subject and t.n_subject = t1.n_subject);
    
# 8	Вывести список студентов из группы, в кот. учится Федорчук (написать 3 запроса, один с пользованием предиката Exists)
select student_name, student_surname from students
	where n_group in (select n_group from students where student_surname = "Гвюднадоуттир");
    
select student_name, student_surname from students
	where n_group = any(select n_group from students where student_surname = "Гвюднадоуттир");
    
select student_name, student_surname from students t1
	where exists (select * from students t2 where student_surname = "Гвюднадоуттир" and t1.n_group = t2.n_group);

# 9	Вывести фамилии преподавателей, кот. принимали более, чем 1 экзамен. (написать 2 запроса)
select distinct teacher_name from teachers t1
	where exists (select * from students_subjects natural join teachers group by teacher_name
		having count(distinct n_subject) > 1 and teacher_name = t1.teacher_name);
                  
select distinct teacher_name from teachers
	where teacher_name in (select teacher_name from students_subjects natural join teachers group by teacher_name
		having count(distinct n_subject) > 1);
    
# 10	Вывести информацию о преподавателях, кот. поставили столько же или больше оценок 'пять', чем Точная Влада Евлампиевна
select distinct teacher_name from teachers t1
	where teacher_name in
		(select teacher_name from students_subjects natural join teachers having
			(select (sum(mark=5 and teacher_name = t1.teacher_name)) from students_subjects natural join teachers) >= 
            (select (sum(mark=5 and teacher_name = "Точная Влада Евлампиевна")) from students_subjects natural join teachers))
		and teacher_name not like "Точная Влада Евлампиевна";

# select teacher_name, sum(mark=5) from students_subjects natural join teachers group by teacher_name;

# 11	Вывести фамилии студентов и все их оценки по каждому предмету
#		(написать 2 типа запроса: использовать соединение и вложенный запрос в предложении Select)
select student_name, student_surname, subject_name, teacher_name, mark 
	from students_subjects natural join students natural join teachers;
    

select (select student_surname from students t1 where t1.n_zach = t0.n_zach) as stud,
	   (select subject_name from teachers t2 where t2.n_subject = t0.n_subject) as subj,
       (select teacher_name from teachers t3 where t3.n_subject = t0.n_subject) as teach,
       mark from students_subjects t0;

#12	Вывести фамилии преподавателей, кот. принимали экзамены у студентов 44 группы 
# (написать 2 запроса, один с использованием предиката Exists)
select distinct teacher_name from students natural join students_subjects natural join teachers where (n_group = 44);

select distinct teacher_name from teachers t1 where exists 
	(select * from students_subjects
		where n_zach in (select n_zach from students where n_group = 44) 
        and n_subject in (select n_subject from teachers t2 where t1.teacher_name = t2.teacher_name));

#13	Узнать, у студентов каких групп не принимал экзамен Один Асгардович Вранов 
# (написать 2 запроса, один с использованием предиката Exists)
select distinct n_group from students natural join students_subjects natural join teachers
	where n_group not in
		(select distinct n_group from students natural join students_subjects natural join teachers
			where teacher_name = "Один Асгардович Вранов");

select distinct n_group from students t1 natural join students_subjects natural join teachers
	where not exists (select distinct n_group from students t2 natural join students_subjects natural join teachers
			where teacher_name = "Один Асгардович Вранов" and t1.n_group = t2.n_group);

#14	Вывести фамилии преподавателей, поставивших больше, чем одну "двойку" (написать 2 запроса)
select distinct teacher_name from students_subjects natural join teachers group by teacher_name having sum(mark=2) > 1;

select distinct teacher_name from teachers t1
	where 1 < (select count(case when mark=2 then 1 else null end) from students_subjects
		where n_subject in 
			(select n_subject from teachers t2 where t1.teacher_name = t2.teacher_name));
# select teacher_name, sum(mark=2) from students_subjects natural join teachers group by teacher_name;

#15	Вывести фамилии преподавателей, поставивших больше всего "двоек"
select teacher_name from students_subjects natural join teachers group by teacher_name
	having sum(mark=2) = (
		select max(twos) from (
			select sum(mark=2) as twos from students_subjects natural join teachers group by teacher_name) as t1);

