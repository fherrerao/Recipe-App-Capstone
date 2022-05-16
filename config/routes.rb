Rails.application.routes.draw do 
  devise_for :users
  resources :foods
  resources :recipes

  root "foods#index"
end
