Rails.application.routes.draw do
  resources :users, only: [:create]
  post '/login', to: 'users#login'
  resources :units, only: %i[index show] do
    resources :measurements, only: %i[create update destroy]
  end
  resources :measurements, only: [:index]
end
