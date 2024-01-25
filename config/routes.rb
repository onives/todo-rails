# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "todos#index"
  # get '/todos', to: 'todos#index'
  # get '/todos/new', to: 'todos#new'
  # post '/todos', to: 'todos#create'
  # get '/todos/:id', to: 'todos#show'
  resources :todos, only: %i[index show create new]
end
