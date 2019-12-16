# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index"

  get    "/welcome", to: "sessions#new",     as: :welcome
  post   "/login",   to: "sessions#create",  as: :login
  delete "/logout",  to: "sessions#destroy", as: :logout


  namespace "api" do
    resources :follow_relationships, only: [:index, :create, :destroy]
    resources :log_followings, only: [:index, :create, :destroy]
  end

  resources :users do
    get :follows, on: :member
    get :followers, on: :member
    get :activate, on: :member
    resource :follow_relationships, only: [:create, :destroy]
  end

  resources :logs

  resources :values, only: [:create, :destroy]

  get "/about", to: "home#about"
  get "/privacy", to: "home#privacy"
  get "/discramer", to: "home#discramer"
end
