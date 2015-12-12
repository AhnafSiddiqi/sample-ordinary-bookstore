Rails.application.routes.draw do
  # login routes
  root to: 'sessions#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'signup'  => 'users#new'

  resources :users, only: [:show, :destroy]
  resources :users, path: 'signup', only: [:create]
end
