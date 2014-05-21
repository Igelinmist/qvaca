Rails.application.routes.draw do

  devise_for :users

  concern :commentable do
    resources :comments, only: [:new, :create, :update, :index]
  end

  resources :questions do
    concerns :commentable
    resources :answers, only: [:new, :create, :edit, :update]
  end

  resources :answers, only: [:destroy] do
    concerns :commentable
  end

  resources :comments, only: [:edit, :destroy]

  root to: 'questions#index'

end
