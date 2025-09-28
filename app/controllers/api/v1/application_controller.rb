module Api
  module V1
    class ApplicationController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

      def not_found(e)
        render json: { error: e.message }, status: :not_found
      end

      def unprocessable_entity(e)
        render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
