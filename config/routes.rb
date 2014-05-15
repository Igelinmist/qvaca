Rails.application.routes.draw do
  
  devise_for :users

  resources :questions do
    resources :answers 
  end

  resources :comments

  root to: "questions#index"

end
