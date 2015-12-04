Rails.application.routes.draw do
  # login routes
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'signup'  => 'users#new'

  resources :users, only: [:destroy]
  resources :users, path: 'signup', only: [:create]
end
