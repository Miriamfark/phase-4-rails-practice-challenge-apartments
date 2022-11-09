class ApartmentsController < ApplicationController
    def index 
        render json: Apartment.all
    end

    def create 
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def update 
        apartment = Apartment.find(params[:id])
        apartment.update(apartment_params)
        render json: apartment
    rescue ActiveRecord::RecordNotFound
        not_found_error_message
    end

    def destroy 
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound 
        not_found_error_message
    end

    private

    def apartment_params 
        params.permit(:number)
    end

    def not_found_error_message 
        render json: { error: "Apartment not found"}, status: :not_found
    end
end
