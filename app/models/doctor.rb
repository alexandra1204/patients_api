class Doctor < ApplicationRecord
  has_many :patient_doctors, dependent: :destroy
  has_many :patients, through: :patient_doctors

  validates :first_name, :last_name, presence: true
end
