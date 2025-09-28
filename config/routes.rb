Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :doctors, only: [:index, :show, :create, :update, :destroy]
      resources :patients do
        resources :bmr_calculations, only: [:index, :create]
        post 'bmi', to: 'bmi#create'
      end
    end
  end
end
