class CreatePatientDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_doctors do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
      t.timestamps
    end

    add_index :patient_doctors, [:patient_id, :doctor_id], unique: true
  end
end
