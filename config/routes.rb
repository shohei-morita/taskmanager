Rails.application.routes.draw do
  root 'users#new'
  resources :tasks do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: %i(new create destroy)
  resources :users, only: %i(new create show)
end
