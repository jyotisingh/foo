Investment::Application.routes.draw do
  resources :funds
  resources :users do
    resources :assets
  end
end
