Rails.application.routes.draw do 
  resources :foods
  root "foods#index"
end
