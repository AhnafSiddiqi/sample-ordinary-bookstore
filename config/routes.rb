Rails.application.routes.draw do
  # login routes
  get 'login' => 'sessions#new'
  post 'login' => 'sessoins#create'
  delete 'login' => 'sessions#destroy'

end
