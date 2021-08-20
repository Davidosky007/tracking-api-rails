Rails.application.routes.draw do
  
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
  resources :measurements do
    resources :measures
  end
  end

    scope module: :v2, constraints: ApiVersion.new('v2') do
    resources :measurements, only: :index
  end
  
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'


end