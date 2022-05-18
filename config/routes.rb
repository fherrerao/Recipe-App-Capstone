Rails.application.routes.draw do 
  devise_for :users
  resources :foods
  resources :recipes do
    resources :recipe_foods, only: [:create, :destroy]
  end


  root "foods#index"
end
