Rails.application.routes.draw do
  
  devise_for :users

  resources :questions do
    resources :answers do
      resources :comments
    end
    resources :comments
  end

  resources :comments

  root to: "questions#index"

end
