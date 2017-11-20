Rails.application.routes.draw do
  resources :tasks
    
  resources :users

  resources :events do 
    resources :tasks, shallow: true, only: [:create, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:new, :create, :destroy]

  resources :events, only: [:index, :new, :create]

  get '/dashboards/index', to: 'dashboards#index'

  namespace :admin do
    resources :dashboard, only: [:index]
  end
  
  root "events#index"
end
