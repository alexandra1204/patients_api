module Api
  module V1
    class BmrCalculationsController < ApplicationController
      def index
        patient = Patient.find(params[:patient_id])
        limit = [params.fetch(:limit, 20).to_i, 200].min
        offset = params.fetch(:offset, 0).to_i
        total = patient.bmr_calculations.count
        records = patient.bmr_calculations.order(created_at: :desc).limit(limit).offset(offset)
        render json: { total: total, data: records.as_json(only: [:id, :formula, :value, :created_at]) }
      end

      def create
        patient = Patient.find(params[:patient_id])
        formula = params[:formula] || params.dig(:bmr, :formula)
        raise ActiveRecord::RecordInvalid.new(patient) if formula.blank?

        value = BmrCalculator.calculate(patient: patient, formula: formula)
        record = patient.bmr_calculations.create!(formula: formula, value: value)
        render json: record.as_json(only: [:id, :formula, :value, :created_at]), status: :created
      end
    end
  end
end
