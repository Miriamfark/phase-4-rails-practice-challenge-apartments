class TenantsController < ApplicationController
    def index 
        render json: Tenant.all
    end

    def create 
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def update 
        tenant = Tenant.find(params[:id])
        tenant.update(tenant_params)
        render json: tenant
    rescue ActiveRecord::RecordNotFound
        not_found_error_message
    end

    def destroy 
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound 
        not_found_error_message
    end

    private

    def tenant_params 
        params.permit(:name, :age)
    end

    def not_found_error_message 
        render json: { error: "Tenant not found"}, status: :not_found
    end
end
