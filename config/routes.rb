Rails.application.routes.draw do 
  devise_for :users
  resources :foods
  resources :general_shopping_list, only: [:index, :update]
  resources :recipes do
    resources :recipe_foods, only: [:create, :destroy]
  end


  root "foods#index"
end
