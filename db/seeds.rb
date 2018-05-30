# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#  movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#  Character.create(name: 'Luke', movie: movies.first)

# Severities
severities = %w[Grave Normal Leve]
severities.each do |sev|
  Severity.create(name: sev)
end

# Types
types = [['Positiva', false],
         ['Negativa', true],
         ['Neutra', false],
         ['Suspensión', false]]
types.each do |typ, sev|
  Type.create(name: typ, has_severity: sev)
end

# Additional subjects
additional_subjects = %w[Patio Gimnasio Misa]
additional_subjects.each do |add|
  AdditionalSubject.create(name: add)
end

# Categories
categories = [['Respeto', 'Negativa', 'Falta de respeto en clases', 'Grave'],
              ['Puntualidad', 'Negativa', 'Llega tarde a clases', 'Normal'],
              ['Responsabilidad', 'Negativa', 'No trae material', 'Leve'],
              ['Compañerismo', 'Positiva', 'Ayuda a compañeros', ''],
              ['Orden', 'Positiva', 'Ordena el puesto o la sala', ''],
              [
                'No trae cotona', 'Negativa', 'Alumno olvida traer su cotona',
                'Leve'
              ],
              [
                'No se come colación', 'Negativa',
                'Alumno no quiere comer su colación', 'Leve'
              ],
              [
                'Usar celular', 'Negativa',
                'Alumno utiliza el celular durante la clase', 'Normal'
              ]]

categories.each do |cat, typ, des, sev|
  Category.create(name: cat,
                  severity: sev == '' ? nil : Severity.find_by(name: sev),
                  type: Type.find_by(name: typ),
                  default_description: des)
end

# Annotations
students1 = [{ "student_id": 68 }, { "student_id": 75 }]
Annotation.create!(detail: 'El alumno dice groserias en la sala',
                  is_additional_subject: false,
                  subject_id: 2,
                  category: Category.find_by(name: 'Respeto'),
                  creator_id: 5,
                  date: Date.today,
                  group_id: 6,
                  is_group: false,
                  annotated_students_attributes: students1)

students2 = []
(30..43).each do |n|
  students2 << { "student_id": n }
end

Annotation.create!(detail: 'El alumno llega tarde a clases de religión',
                  is_additional_subject: false,
                  subject_id: 13, # 13: religion
                  category: Category.find_by(name: 'Puntualidad'),
                  creator_id: 5,
                  date: Date.today,
                  group_id: 26, # curso id 26, alumnos 14 a 50
                  is_group: false,
                  annotated_students_attributes: students2)

Annotation.create!(detail: 'Alumnos comparten sus colaciones',
                  is_additional_subject: false,
                  subject_id: 2, # 2: matematicas
                  category: Category.find_by(name: 'Compañerismo'),
                  creator_id: 4,
                  date: Date.today,
                  group_id: 27, # curso id 27, alumnos 51 a 87
                  is_group: true)

students3 = []
(90..100).each do |n|
  students3 << { 'student_id': n }
end

Annotation.create!(detail: 'Orden impecable en la sala',
                  is_additional_subject: false,
                  subject_id: 3, # 3: tecnologia
                  category: Category.find_by(name: 'Orden'),
                  creator_id: 4,
                  date: Date.today,
                  group_id: 27, # 1 basico A
                  is_group: false,
                  annotated_students_attributes: students3)

Annotation.create!(detail: 'Saca el celular en medio de la clase',
                  is_additional_subject: false,
                  subject_id: 7, # 7: ingles
                  category: Category.find_by(name: 'Usar celular'),
                  creator_id: 4,
                  date: Date.today,
                  group_id: 27, # I A
                  is_group: false,
                  annotated_students_attributes: [{ "student_id": 57 }])

Annotation.create!(detail: 'Insulta a profesor',
                  is_additional_subject: false,
                  subject_id: 9, # 9: musica
                  category: Category.find_by(name: 'Respeto'),
                  creator_id: 4,
                  date: Date.today,
                  group_id: 26, # I A
                  is_group: false,
                  annotated_students_attributes: [{ "student_id": 42 }])

# Cycles
c1 = Cycle.create(name: 'Ciclo 1',
                  categories: [
                    Category.find_by(name: 'No trae cotona'),
                    Category.find_by(name: 'No se come colación'),
                    Category.find_by(name: 'Orden')
                  ])

c2 = Cycle.create(name: 'Ciclo 2',
                  categories: [
                    Category.find_by(name: 'Compañerismo'),
                    Category.find_by(name: 'Responsabilidad'),
                    Category.find_by(name: 'Puntualidad')
                  ])

c3 = Cycle.create(name: 'Ciclo 3',
                  categories: [
                    Category.find_by(name: 'Puntualidad'),
                    Category.find_by(name: 'Respeto'),
                    Category.find_by(name: 'Usar celular')
                  ])

(1..7).each do |group_level_id|
  CycleLevel.create(cycle: c1, group_level_id: group_level_id)
end

(8..13).each do |group_level_id|
  CycleLevel.create(cycle: c2, group_level_id: group_level_id)
end

(14..17).each do |group_level_id|
  CycleLevel.create(cycle: c3, group_level_id: group_level_id)
end

# Group level ids:
# 2: nivel medio menor
# 3: nivel medio mayor
# 11: 6 basico
# 13: 8 basico
