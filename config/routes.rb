Rails.application.routes.draw do
  # login routes
  root to: 'sessions#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  # signup routes
  get 'signup'  => 'users#new'

  post 'books/:id' => 'books#show'

  resources :users,                 only: [:show, :destroy]
  resources :customers,             only: [:show, :update]
  resources :users, path: 'signup', only: [:create]
  resources :books,                 only: [:update, :index, :create, :new, :show]
  resources :orders,                only: [:create, :show, :destroy]
  resources :reviews,               only: [:new, :create]
  resources :review_ratings,        onlt: [:create]
  resources :order_items, only: [:create] do
    collection do
      post :add
      post :rmv
    end
  end
end
