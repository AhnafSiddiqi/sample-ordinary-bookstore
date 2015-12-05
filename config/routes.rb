Rails.application.routes.draw do

  # login routes
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  # signup routes
  get 'signup'  => 'users#new'


  resources :users, only: [:show, :destroy]
  resources :users, path: 'signup', only: [:create]

  resources :books, only: [:update, :index, :create]
end
