class LeasesController < ApplicationController
    def create 
        lease = Lease.create!(rent: params[:rent], apartment_id: params[:apartment_id], tenant_id: params[:tenant_id])
        render json: lease, status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy 
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound 
        render json: { error: "Lease not found" }, status: :not_found
    end
end
