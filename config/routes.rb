Rails.application.routes.draw do 
  devise_for :users
  resources :foods
  put 'ingredients/:id', as: 'recipe_food_update', action: :update_two, controller: 'foods'
  resources :recipes do
    resources :recipe_foods do
    end
  end


  root "foods#index"
end
