Rails.application.routes.draw do
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  namespace :admin do
    resources :words
  end

  resources :categories, only: [:index, :show]
  resources :words, only: [:index]
  resources :lessons

  resources :users do
    resources :relationships, only: [:index]
  end
  resources :relationships, only: [:create, :destroy]

end
