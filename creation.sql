#use student_db33;studentsstudents
drop table if exists students_subjects;
drop table if exists teachers;
drop table if exists students;

# создаём таблицы
create table IF NOT EXISTS students (
	n_zach integer primary key unique,
	student_name varchar(32) not null,
	student_surname varchar(32) not null,
	student_lastname varchar(32),
    number_telephone integer,
    n_group integer
) charset = utf8;

create table IF NOT EXISTS teachers (
	n_subject integer primary key auto_increment,
    subject_name varchar(64) not null,
    teacher_name char(128) not null
)charset = utf8;

create table IF NOT EXISTS students_subjects (
	n_zach int,
    n_subject int,
    mark tinyint,
	foreign key (n_zach) references students (n_zach),
    foreign key (n_subject) references teachers (n_subject),
    primary key (n_zach, n_subject)
)charset = utf8;

# заполняем таблицы
insert into students(n_zach, student_name, student_surname, student_lastname, number_telephone, n_group) values 
	(7141, "Гюннар", "Йоунассон", "Стейнар",940977, 34),
    (8950, "Бальдюр", "Йоунссон", "Кристьян",363348, 44),
    (6986, "Бальдюр", "Торкельссон", "Синдри", 489389, 25),
	(3136, "Торстейдн", "Гримссон", "Йоунас", 515226, 45),
    (5211, "Сверрир", "Фридрикссон", "Бьёдн", 576194, 14),
    (7584, "Ингибьёрг", "Тоумасдоуттир", "Сигюрбьёрг", 621932, 15),
    (4906, "Ауслёйг", "Торкельсдоуттир", "Эльса", 139227, 44),
    (8970, "Бьёрг", "Сигфусдоуттир", "Роуса", 728365, 34),
    (7443, "Тоура", "Йоунасдоуттир", "Сванхильдюр", 438703, 24),
    (8769, "Сигридюр", "Гвюднадоуттир", "Кристьяна", 194119, 35);

insert into teachers(subject_name, teacher_name) values 
	("Скандинавские руны", "Любим Кронидович Быховский"),
	("Приручение медведей", "Афродита Аполлоновна Ершова"),
	("Метание топоров", "Любомир Платонович Вояковский"),
	("Вальгалловедение", "Один Асгардович Вранов"),
	("ОБЖ", "Гера Цезаревна Водова");

insert into students_subjects(n_zach, n_subject, mark) values 
	(7141, 3, 4),
    (8950, 4, 3),
    (6986, 1, 5),
    (6986, 2, 3),
	(3136, 4, 2),
    (5211, 5, 5),
    (7584, 5, 3),
    (4906, 4, 5),
    (8970, 3, 2),
    (7443, 1, 2),
    (7443, 2, 4),
    (8769, 3, 5);

