Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/login', to: 'users#login'
  get '/auto_login', to: 'users#auto_login'
  delete '/logout', to: 'users#logout'
  resources :users, only: [:create]
  resources :units, only: %i[index show] do
    resources :measurements, only: %i[create update destroy]
  end
  resources :measurements, only: [:index]
end
