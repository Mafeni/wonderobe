Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :listings do
    resources :transactions, only: [:new, :create]
  end

  resources :users, only: %i[show edit update]
  # get 'profile', action: :show, controller: 'users'

  resources :users do
    resources :reviews,  only: [:new, :create]
  end
end
