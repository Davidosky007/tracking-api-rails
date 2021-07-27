Rails.application.routes.draw do
  resources :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  delete "/logout", to: "users#logout"
  resources :units, only: [:index, :show] do
    resources :measurements, only: [:create, :update, :destroy]
  end
  resources :measurements, only: [:index]
end
