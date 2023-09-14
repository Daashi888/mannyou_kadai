Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks
  resources :users
  resources :sessions
  root 'tasks#index'
end
