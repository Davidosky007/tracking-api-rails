Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :measurements do
      resources :measures
    end
  end

  resource :authentication, only: [:create]
  post 'signup', to: 'users#create'
end
