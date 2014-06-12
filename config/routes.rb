Rails.application.routes.draw do

  devise_for :users
  resources :profiles, only: [:show]

  concern :commentable do
    resources :comments
  end

  concern :votable do
    get :voteup, on: :member, action: :vote, rate: 1
    get :votedown, on: :member, action: :vote, rate: -1
  end

  resources :questions do
    concerns [:commentable, :votable]
    resources :answers
  end

  resources :answers, only: [] do
    concerns [:commentable, :votable]
    get :thebest, on: :member, action: :vote, rate: 3
  end

  root to: 'questions#index'

end
