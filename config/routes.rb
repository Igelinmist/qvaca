Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
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
    get :thebest, on: :member, action: :is_the_best
  end

  root to: 'questions#index'

end
