Rails.application.routes.draw do
  root 'boards#index'
  resources :boards
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
