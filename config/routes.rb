Rails.application.routes.draw do

  devise_for :users
  resources :profiles, only: [:show]

  concern :commentable do
    resources :comments
  end

  concern :votable do
    get 'voteup', on: :member, action: :vote, type: '+'
    get 'votedown', on: :member, action: :vote, type: '-'
  end

  resources :questions do
    concerns :commentable
    concerns :votable
    resources :answers
  end

  resources :answers, only: [] do
    concerns :commentable
    concerns :votable
  end

  root to: 'questions#index'

end
