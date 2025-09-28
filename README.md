# Patients API (Rails)

Запуск:
1. Создать .env (пример .env.example)
3. Запустить: docker-compose -f docker-compose.yml up -d
4. Прогнать сиды (если нужно): docker-compose run --rm web rails db:setup

Эндпоинты (JSON):
- GET  /api/v1/doctors?limit=&offset=
- GET  /api/v1/doctors/:id
- POST /api/v1/doctors

- GET  /api/v1/patients?full_name=&gender=&start_age=&end_age=&limit=&offset=
- GET  /api/v1/patients/:id
- POST /api/v1/patients  (подключение врачей: doctor_ids: [1,2])
- PUT  /api/v1/patients/:id
- DELETE /api/v1/patients/:id

- POST /api/v1/patients/:patient_id/bmr_calculations  (body: { "formula": "mifflin" })
- GET  /api/v1/patients/:patient_id/bmr_calculations?limit=&offset=

- POST /api/v1/patients/:patient_id/bmi
