Rails.application.routes.draw do 
  devise_for :users
  resources :foods
  put 'ingredients/:id', as: 'recipe_food_update', action: :update_two, controller: 'foods'
  resources :recipes do
    resources :recipe_foods do
    end
  end
  get 'recipes/:id/ingredient/new', as: 'recipes_new_ingredient', action: :edit_two, controller: :recipes
  post 'recipes/:recipe_id/ingredients', as: 'recipes_create_ingredient', action: :update_two, controller: :recipes

  root "foods#index"
end
