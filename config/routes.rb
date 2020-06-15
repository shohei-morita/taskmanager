Rails.application.routes.draw do
  root 'users#new'
  resources :tasks
  resources :sessions, only: %i(new create destroy)
  namespace :admin do
    resources :users
  end
  resources :users, only: %i(new create show edit update)
  resources :labels
  resources :groups
  resources :group_users, only: %i(index create destroy)
end
