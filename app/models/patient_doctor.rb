class PatientDoctor < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor
  validates :patient_id, uniqueness: { scope: :doctor_id }
end
