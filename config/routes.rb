Rails.application.routes.draw do

  devise_for :users

  concern :commentable do
    resources :comments, only: [:new, :create, :update, :index]
  end

  concern :attachmentable do
    resources :attachments, only: [:destroy]
  end

  resources :questions do
    concerns :commentable, :attachmentable
    resources :answers, only: [:new, :create, :edit, :update, :index]
  end

  resources :answers, only: [:destroy] do
    concerns :commentable, :attachmentable
  end

  resources :comments, only: [:edit, :destroy]

  root to: 'questions#index'

end
