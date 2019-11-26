# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "logs#index"

  get    "/welcome", to: "sessions#new",     as: :welcome
  post   "/login",   to: "sessions#create",  as: :login
  delete "/logout",  to: "sessions#destroy", as: :logout

  resources :users

  resources :logs do
    resources :log_followings, only: [:create, :destroy]
  end


  resources :values, only: [:create, :destroy]
end
