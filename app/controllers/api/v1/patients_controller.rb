module Api
  module V1
    class PatientsController < ApplicationController
      def index
        limit = [params.fetch(:limit, 20).to_i, 200].min
        offset = params.fetch(:offset, 0).to_i
        filtered = Patient.filter(params)
        total = filtered.count
        patients = filtered.limit(limit).offset(offset)
        render json: { total: total, data: patients.as_json(include: { doctors: { only: [:id, :first_name, :last_name] } }) }
      end

      def show
        patient = Patient.find(params[:id])
        render json: patient.as_json(include: :doctors)
      end

      def create
        patient = Patient.new(patient_params)
        ActiveRecord::Base.transaction do
          patient.save!
          if params[:doctor_ids].present?
            doctors = Doctor.where(id: params[:doctor_ids])
            patient.doctors = doctors
          end
        end
        render json: patient.as_json(include: :doctors), status: :created
      end

      def update
        patient = Patient.find(params[:id])
        ActiveRecord::Base.transaction do
          patient.update!(patient_params)
          if params.key?(:doctor_ids)
            doctors = Doctor.where(id: params[:doctor_ids])
            patient.doctors = doctors
          end
        end
        render json: patient.as_json(include: :doctors)
      end

      def destroy
        patient = Patient.find(params[:id])
        patient.destroy
        head :no_content
      end

      private

      def patient_params
        params.require(:patient).permit(:first_name, :last_name, :middle_name, :birthday, :gender, :height, :weight)
      end
    end
  end
end
