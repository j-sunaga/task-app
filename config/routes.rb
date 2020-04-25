# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :users, only: %i[new create show edit update]
  resources :sessions, only: %i[new create destroy]

  namespace :admin do
    resources :users
    resources :tasks, only: [:index]
  end

  resources :labels
end
