Rails.application.routes.draw do
  root 'boards#index'
  resources :boards, shallow: true do
    # resources :comments, only: %i[create destroy]
    resource :bookmarks, only: [:create, :destroy]
    collection do
      get :bookmarks
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
