#use student_db33;studentsstudents
drop table if exists students_subjects;
drop table if exists teachers;
drop table if exists students;

# создаём таблицы
create table IF NOT EXISTS students (
	n_zach integer primary key auto_increment,
	student_name varchar(32) not null,
	student_surname varchar(32) not null,
	student_lastname varchar(32),
    number_telephone varchar(30),
    n_group integer
) charset = utf8;

alter table students auto_increment = 17000;

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
insert into students(student_name, student_surname, student_lastname, number_telephone, n_group) values 
	("Гюннар", "Йоунассон", "Стейнар",940977, 34),
    ("Бальдюр", "Йоунссон", "Кристьян",363348, 44),
    ("Бальдюр", "Торкельссон", "Синдри", 489389, 25),
	("Торстейдн", "Гримссон", "Йоунас", 515226, 45),
    ("Сверрир", "Фридрикссон", "Бьёдн", 576194, 14),
    ("Ингибьёрг", "Тоумасдоуттир", "Сигюрбьёрг", 621932, 15),
    ("Ауслёйг", "Торкельсдоуттир", "Эльса", 139227, 44),
    ("Бьёрг", "Сигфусдоуттир", "Роуса", 728365, 34),
    ("Тоура", "Йоунасдоуттир", "Сванхильдюр", 438703, 24),
    ("Сигридюр", "Гвюднадоуттир", "Кристьяна", 194119, 35);

insert into teachers(subject_name, teacher_name) values 
	("Скандинавские руны", "Любим Кронидович Быховский"),
	("Приручение медведей", "Афродита Аполлоновна Ершова"),
	("Метание топоров", "Любомир Платонович Вояковский"),
	("Вальгалловедение", "Один Асгардович Вранов"),
	("ОБЖ", "Гера Цезаревна Водова");

insert into students_subjects(n_zach, n_subject, mark) values 
	(17000, 3, 4),
    (17001, 4, 3),
    (17002, 1, 5),
    (17002, 2, 3),
	(17003, 4, 2),
    (17004, 5, 5),
    (17005, 5, 3),
    (17006, 4, 5),
    (17007, 3, 2),
    (17008, 1, 2),
    (17008, 2, 4),
    (17009, 3, 5);

