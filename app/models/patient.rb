class Patient < ApplicationRecord
  has_many :patient_doctors, dependent: :destroy
  has_many :doctors, through: :patient_doctors
  has_many :bmr_calculations, dependent: :destroy

  validates :first_name, :last_name, :birthday, :gender, :height, :weight, presence: true
  validates :birthday, uniqueness: { scope: [:first_name, :last_name, :middle_name], message: "patient with same name and birthday already exists" }

  # Filters: params is a hash with optional keys: full_name, gender, start_age, end_age
  scope :by_gender, ->(g) { where(gender: g) if g.present? }

  scope :full_name_search, ->(q) {
    return all if q.blank?
    q = "%#{q.downcase}%"
    where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR LOWER(middle_name) LIKE ?", q, q, q)
  }

  scope :age_between, ->(start_age, end_age) {
    return all if start_age.blank? && end_age.blank?
    today = Date.current
    relation = all
    if start_age.present?
      # age >= start_age  => birthday <= today - start_age.years
      max_birthday = today - start_age.to_i.years
      relation = relation.where("birthday <= ?", max_birthday)
    end
    if end_age.present?
      # age <= end_age => birthday >= today - end_age.years
      min_birthday = today - end_age.to_i.years
      relation = relation.where("birthday >= ?", min_birthday)
    end
    relation
  }

  def age
    ((Date.current - birthday).to_i / 365.25).floor
  end

  # Class method to apply filters hash
  def self.filter(params = {})
    res = all
    res = res.full_name_search(params[:full_name]) if params[:full_name].present?
    res = res.by_gender(params[:gender]) if params[:gender].present?
    res = res.age_between(params[:start_age], params[:end_age])
    res
  end
end
