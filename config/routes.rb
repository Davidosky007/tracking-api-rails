Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :measurements do
      resources :measures
    end
  end

  post 'auth/login', to: 'authentication#create'
  post 'signup', to: 'users#create'
end
