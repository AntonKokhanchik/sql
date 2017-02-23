require 'sequel'
require 'faker'
require 'mysql2'
require 'hash_dot'
require 'yaml'

# файл конфигураций, нехорошо в коде прописывать пароль от mysql
@config= YAML.load_file('config.yml').to_dot

# собственно, подключаемся к базе
DB = Sequel.connect(
  adapter: 'mysql2',
  host: @config.db_host,
  database: @config.db_name,
  user: @config.db_user,
  password: @config.db_password
)

# вводим сокращения
students = DB[:students]
teachers = DB[:teachers]
s_s = DB[:students_subjects]

# номера групп в массиве, чтобы выбирать случайно
groups = [34, 35, 44, 45]
# эту часть пришлось сделать самостоятельно - привязка учителей, предметов и курсов (также можно подгружать из yml-файла)
subjects = [["Языки", "Языковедов Степан Ростиславович", 4],
  ["ОБЖ", "Безопасный Никита Феликсович", 3],
  ["Математика", "Точная Влада Евлампиевна", 3],
  ["Искуства", "Красивая Христина Соломоновна", 3],
  ["Мистика", "Невероятный Владислав Мартьянович", 4],
  ["Науковедение", "Учёный Мартын Ульянович", 3],
  ["Науковедение", "Точная Влада Евлампиевна", 4],
  ["Искуства", "Мастеровой Игнатий Климентович", 4]]

# далее будем считать, что таблицы уже созданы (хотя это можно сделать и отсюда)
# случайно заполняем студентов с помощьу faker и rand
30.times do |i|
  students.insert(
    :student_name => Faker::Name.first_name,
    :student_surname => Faker::Name.last_name,
    :student_lastname => Faker::Name.first_name,
    :number_telephone =>
      if rand(0..3)==0 then
        nil
      else
        Faker::PhoneNumber.cell_phone
      end,
    :n_group => groups[rand(groups.size)]
  )
end

# здесь чуть сложнее, для каждой записи из массива subjects
subjects.each do |subject|
  # заполняем создаём запись в таблице teachers
  teachers.insert(
    :subject_name => subject[0],
    :teacher_name => subject[1]
  )

  course = subject[2]
  # и добовляем все экзамены по двнному предмету с данным преподвавтелем (в таблицу students_subjects)
  # то есть ищем всех студентов того курса, на котором данный предмет сдаётся
  students.where(:n_group => [course*10+4, course*10+5]).all.each do |student|
    # и для каждого вставляем в students_subjects его номер зачётки
    s_s.insert(
      :n_zach => student[:n_zach],
      # а также номер предмета, который мы узнаём, обратившись к последней записи в таблице
      :n_subject => teachers.order(:n_subject).last[:n_subject],
      # ну и случайная оценка
      :mark => rand(2..5)
    )
  end
end
