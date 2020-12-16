Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  resources :pets
  resources :applications
  resources :shelters do
    resources :pets, controller: "shelter_pets", only: [:index, :new, :create]
  end
  resources :application_pets, except: [:index]
  
  namespace :admin do
    resources :applications, only: [:show]
    resources :application_pets, only: [:update]
    resources :shelters, only: [:index, :show]
  end
end
