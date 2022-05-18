class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[show edit update destroy]
  load_and_authorize_resource

  def create; end

  def destroy
    @recipe_food.destroy

    flash[:success] = 'Recipe food has been deleted successfully'
    redirect_to recipe_url(@recipe.id)
  end

  private

  def set_recipe_food
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
  end
end
