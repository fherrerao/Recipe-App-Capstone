Rails.application.routes.draw do 
  resources :foods
  resources :recipes

  root "foods#index"
end
