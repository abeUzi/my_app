Rails.application.routes.draw do
  devise_for :users

  root 'entry#index'
  resources :entry
end
