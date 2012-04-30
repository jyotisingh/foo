Investment::Application.routes.draw do
  resources :funds
  resources :users, :only => [:new, :edit, :create, :update] do
    resources :assets
  end

  namespace :admin do
    resources :funds
  end
end
