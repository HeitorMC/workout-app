# frozen_string_literal: true

Rails.application.routes.draw do
  resources :exercises
  resources :workouts
  devise_for :users
  root 'workouts#index'
end
