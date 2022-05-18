class RecipeFoodsController < ApplicationController
  def create; end

  def destroy
    @recipe_food.destroy

    flash[:success] = 'Recipe food has been deleted successfully'
    redirect_to recipe_url(@recipe_food.recipe_id)
  end

  private

  def set_recipe_food
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.foods.find(params[:id])
  end
end
