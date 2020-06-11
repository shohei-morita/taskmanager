Rails.application.routes.draw do
  get 'labels/index'
  get 'labels/new'
  get 'labels/edit'
  root 'users#new'
  resources :tasks do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: %i(new create destroy)
  namespace :admin do
    resources :users
  end
  resources :users, only: %i(new create show)
  resources :labels
end
