# frozen_string_literal: true

Rails.application.routes.draw do
  get "follow_relationships/create"
  get "follow_relationships/destroy"
  root to: "logs#index"

  get    "/welcome", to: "sessions#new",     as: :welcome
  post   "/login",   to: "sessions#create",  as: :login
  delete "/logout",  to: "sessions#destroy", as: :logout

  resources :users do
    resource :follow_relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :logs do
    resources :log_followings, only: [:create, :destroy]
  end


  resources :values, only: [:create, :destroy]
end
