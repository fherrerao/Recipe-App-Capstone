Rails.application.routes.draw do 
  devise_for :users
  resources :foods
  resources :recipes do
    resources :recipe_foods
  end


  root "foods#index"
end
