Rails.application.routes.draw do
  get 'transactions/new'
  get 'transactions/create'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :listings do
    resources :transactions, only: [:new, :create]
  end

  resources :users, only: %i[show]
  # get 'profile', action: :show, controller: 'users'

end
