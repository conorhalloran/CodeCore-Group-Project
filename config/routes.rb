Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :events do
    resources :tasks, shallow: true, only: [:create, :edit, :update, :destroy]
  end
  resources :memberships, only: [:create]
  namespace :admin do
    resources :dashboard, only: [:index]
  end
  root "events#index"
end
