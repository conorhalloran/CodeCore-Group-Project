Rails.application.routes.draw do
  resources :users

  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:new, :create, :destroy]

  get '/dashboards/index', to: 'dashboards#index'

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  root "events#index"
end
