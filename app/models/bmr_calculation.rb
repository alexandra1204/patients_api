class BmrCalculation < ApplicationRecord
  belongs_to :patient
  validates :formula, presence: true
  validates :value, presence: true
end
