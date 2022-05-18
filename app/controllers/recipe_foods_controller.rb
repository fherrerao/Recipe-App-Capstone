class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[show edit update destroy]
  load_and_authorize_resource

  def edit
    @food = Food.find(@recipe_food.food_id)
  end

  def update
    respond_to do |format|
      if @recipe_food.update(recipe_food_params)
        flash[:success] = 'Recipe food has been updated successfully'
        format.html { redirect_to recipe_url(@recipe), notice: 'Food was successfully updated.' }
      else
        flash[:error] = 'Error: Recipe food could not be updated'
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def create; end

  def destroy
    @recipe_food.destroy

    flash[:success] = 'Recipe food has been deleted successfully'
    redirect_to recipe_url(@recipe.id)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :value)
  end

  def set_recipe_food
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
  end
end
