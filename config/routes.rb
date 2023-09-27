Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks
  resources :users
  resources :sessions
  root 'tasks#index'

  namespace :admin do
    resources :users
  end
end
