Rails.application.routes.draw do
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:new, :create, :destroy]

  namespace :admin do
    resources :dashboard, only: [:index]
  end
  get '/dashboards/index', to: 'dashboards#index'
  root "events#index"
end
