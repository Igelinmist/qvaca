Rails.application.routes.draw do

  devise_for :users

  concern :commentable do
    resources :comments, only: [:new, :create, :update, :index]
  end

  resources :questions do
    get 'like', on: :member, action: :vote, type: '+'
    get 'dislike', on: :member, action: :vote, type: '-'
    concerns :commentable
    resources :answers, only: [:new, :create, :edit, :update, :index]
  end

  resources :answers, only: [:destroy] do
    get 'like', on: :member, action: :vote, type: '+'
    get 'dislike', on: :member, action: :vote, type: '-'
    concerns :commentable
  end

  resources :comments, only: [:edit, :destroy]

  root to: 'questions#index'

end
