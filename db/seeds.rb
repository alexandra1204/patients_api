# db/seeds.rb

Patient.destroy_all
Doctor.destroy_all

# создаем докторов
doctors = Doctor.create!([
  { first_name: "Иван", last_name: "Иванов", middle_name: "Иванович" },
  { first_name: "Петр", last_name: "Петров", middle_name: "Петрович" }
])

# создаем пациентов
patients = Patient.create!([
  { first_name: "Анна", last_name: "Сидорова", birthday: "1990-05-12", gender: "female", height: 165, weight: 60 },
  { first_name: "Алексей", last_name: "Кузнецов", birthday: "1985-03-20", gender: "male", height: 180, weight: 82 },
  { first_name: "Мария", last_name: "Иванова", birthday: "2000-11-01", gender: "female", height: 170, weight: 65 }
])

# связываем пациентов и докторов (many-to-many)
patients[0].doctors << doctors[0]
patients[1].doctors << doctors[1]
patients[2].doctors << doctors
