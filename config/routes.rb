Rails.application.routes.draw do

  root to: 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show,:edit,:update]
  resources :sessions, only:[:new,:create,:destroy]

  namespace :admin do
    resources :users
    resources :tasks, only: [:index]
  end

end
