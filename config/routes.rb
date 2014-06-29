Rails.application.routes.draw do

  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :profiles, only: [:show, :edit, :update]

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
    get :thebest, on: :member, action: :mark_the_best
  end

  namespace :api do
    namespace :v1 do
      resources :profiles do
        get :me, on: :collection
      end
    end
  end

  root to: 'questions#index'

end
