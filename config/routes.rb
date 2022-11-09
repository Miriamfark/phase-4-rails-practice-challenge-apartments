Rails.application.routes.draw do
  resources :apartments, only: [:index, :create, :update, :destroy]
  resources :tenants, only: [:index, :create, :update, :destroy]
  resources :leases, only: [:create, :destroy]
end
