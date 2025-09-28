class BmrCalculator
  # formulas: :mifflin or :harris
  def self.calculate(patient:, formula:)
    age = patient.age
    weight = patient.weight.to_f
    height = patient.height.to_f
    gender = patient.gender.to_s.downcase

    case formula.to_s.downcase
    when 'mifflin', 'mifflin-st-jeor', 'mifflin_st_jeor'
      # Mifflin–St Jeor
      s = (gender == 'male' || gender == 'm') ? 5 : -161
      value = 10 * weight + 6.25 * height - 5 * age + s
    when 'harris', 'harris-benedict', 'harris_benedict'
      # Original Harris-Benedict
      if gender == 'male' || gender == 'm'
        value = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age)
      else
        value = 655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age)
      end
    else
      raise ArgumentError, "Unknown formula: #{formula}"
    end

    value.round(2)
  end
end
