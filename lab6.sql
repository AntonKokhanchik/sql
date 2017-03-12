# 1. Добавить в таблицу Студенты нового студента.
insert into students (student_name, student_lastname, student_surname, n_group, number_telephone)
value ("Петр", "Петрович", "Петров", 45, "874598");

# 2. Удалить любого студента из списка студентов.
SET SQL_SAFE_UPDATES = 0;
delete from students where student_surname = "Петров";
SET SQL_SAFE_UPDATES = 1;

# 3. Изменить № группы у одного студента.
update students set n_group = 44 where n_zach = 17030;

# 4. С помощью команды Create table создать новые таблицы по числу групп
# и "рассортировать" студентов из таблицы Студенты по полю № группы в новые таблицы (в задании несколько запросов)
drop table if exists group14;
drop table if exists group15;
drop table if exists group24;
drop table if exists group25;
drop table if exists group34;
drop table if exists group35;
drop table if exists group44;
drop table if exists group45;
CREATE TABLE group14 select * from students where n_group = 14;
CREATE TABLE group15 select * from students where n_group = 15;
CREATE TABLE group24 select * from students where n_group = 24;
CREATE TABLE group25 select * from students where n_group = 25;
CREATE TABLE group34 select * from students where n_group = 34;
CREATE TABLE group35 select * from students where n_group = 35;
CREATE TABLE group44 select * from students where n_group = 44;
CREATE TABLE group45 select * from students where n_group = 45;

# 5. С помощью команды Create table создать копию таблицы Студенты с именем Студенты_2017, найти и объединить 2 
# малочисленные группы в одну.
drop table if exists Студенты_2017;

create table Студенты_2017 select * from students;
update Студенты_2017 set n_group = 20 where n_group in 
	(select n_group from (select n_group, count(n_zach) as c from students group by n_group) as t1
		where c = (select min(c) from (select n_group, count(n_zach) as c from students group by n_group) as t2));

# 6. Студентов, успешно сдавших экзамены, скопировать в таблицу Студенты_перевод и перевести на следeдующий курс (изменить № группы),
# а студентов, не сдавших экзамены, скопировать в таблицу Студенты_отчисление.
drop table if exists Студенты_перевод;
CREATE TABLE Студенты_перевод select * from students where n_zach in
	(select n_zach from students_subjects group by n_zach having sum(mark=2)=0);
update Студенты_2017 set n_group = n_group + 10;

drop table if exists Студенты_отчисление;
CREATE TABLE Студенты_отчисление select * from students where n_zach in
	(select n_zach from students_subjects group by n_zach having 
		sum(mark=2) > 2);
		#sum(mark = 3) + sum(mark = 5) + sum(mark = 4) = 0);

# 7. Из таблицы Студенты_2017 удалить студентов 45 группы 
delete from Студенты_2017 where n_group = 45;

# 8. С помощью команды Create table создать таблицу Кафедры (№ кафедры, название) (№кафедры – первичный ключ и счетчик).
# Вставить 3 новые записи в созданную таблицу.
# Добавить к таблице Предметы поле кафедра, создать по нему внешний ключ к таблице Кафедры.
# В таблице Предметы заполнить поле Кафедра для всех преподавателей.
alter table teachers drop foreign key n_dep;

drop table if exists deprtments;
create table departments(
	n_dep TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    dep_name VARCHAR(50) NOT NULL
);
insert into departments (dep_name) value
	("Северные науки"), ("Околонаучные знания"), ("Развитие личности");

alter table teachers 
	add column n_dep tinyint UNSIGNED, 
	add foreign key (n_dep) references departments(n_dep);
update teachers set n_dep = 1 where subject_name in 
	("Метание топоров", "Скандинавские руны", "Вальгалловедение", "Приручение медведей");
update teachers set n_dep = 2 where subject_name in 
	("Математика", "Науковедение", "Мистика");
update teachers set n_dep = 3 where subject_name in
	("Искуства", "Языки", "ОБЖ");

# 9. Создать в таблице Предметы индекс по полю фамилия.
alter table teachers add index teacher_name_index (teacher_name);

# 10. В таблице Студенты_2017 удалить поле телефон.
alter table Студенты_2017 drop column number_telephone;

# 11. Удалить таблицу Студенты_2017.
drop table if exists Студенты_2017;