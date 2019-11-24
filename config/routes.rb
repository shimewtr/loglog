# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "logs#index"

  resources :logs
end
