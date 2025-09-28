require 'httparty'
module Api
  module V1
    class BmiController < ApplicationController
      def create
        patient = Patient.find(params[:patient_id])

        height_cm = patient.height
        weight_kg = patient.weight

        bmi_api = ENV['BMI_API_URL'].presence

        if bmi_api.present?
          # send to external service (expected query params: height, weight) — configurable via ENV
          begin
            response = HTTParty.get(bmi_api, query: { height: height_cm, weight: weight_kg }, timeout: 5)
            if response.success?
              render json: { external: true, result: response.parsed_response }
              return
            end
          rescue StandardError => e
            Rails.logger.warn("BMI API call failed: #{e.message}")
            # fallthrough to local calculation
          end
        end

        # Fallback local BMI
        height_m = height_cm.to_f / 100.0
        bmi_value = (weight_kg.to_f / (height_m * height_m)).round(2)
        category = case bmi_value
        when 0..18.4 then "Underweight"
        when 18.5..24.9 then "Normal"
        when 25..29.9 then "Overweight"
        else "Obesity"
        end

        render json: { external: false, bmi: bmi_value, category: category }
      end
    end
  end
end
