Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :messages, only: :create
      namespace :users do
        resources :registrations, only: :create
      end
    end
  end
end
