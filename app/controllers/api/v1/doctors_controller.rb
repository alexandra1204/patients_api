module Api
  module V1
    class DoctorsController < ApplicationController
      def index
        limit = [params.fetch(:limit, 20).to_i, 100].min
        offset = params.fetch(:offset, 0).to_i
        doctors = Doctor.limit(limit).offset(offset)
        render json: { data: doctors.as_json(only: [:id, :first_name, :last_name, :middle_name]), total: Doctor.count }
      end

      def show
        doctor = Doctor.find(params[:id])
        render json: doctor.as_json(include: { patients: { only: [:id, :first_name, :last_name] } })
      end

      def create
        doctor = Doctor.create!(doctor_params)
        render json: doctor, status: :created
      end

      def update
        doctor = Doctor.find(params[:id])
        doctor.update!(doctor_params)
        render json: doctor
      end

      def destroy
        doctor = Doctor.find(params[:id])
        doctor.destroy
        head :no_content
      end

      private

      def doctor_params
        params.require(:doctor).permit(:first_name, :last_name, :middle_name)
      end
    end
  end
end
