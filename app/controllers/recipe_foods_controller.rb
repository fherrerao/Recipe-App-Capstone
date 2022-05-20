class RecipeFoodsController < ApplicationController
  before_action :set_recipe, only: %i[new create show edit update destroy]
  before_action :set_recipe_food, only: %i[show edit update destroy]
  load_and_authorize_resource

  def edit
    @food = Food.find(@recipe_food.food_id)
  end

  def update
    respond_to do |format|
      if @recipe_food.update(recipe_food_params)
        flash[:success] = 'Recipe food has been updated successfully'
        format.html { redirect_to recipe_url(@recipe) }
      else
        flash[:error] = 'Error: Recipe food could not be updated'
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def create
    @recipe_food = RecipeFood.new(ingredient_params)
    @recipe_food.recipe = @recipe
    @recipe_food.food = Food.find(params[:food_id])
    respond_to do |format|
      if @recipe_food.save
        flash[:success] = 'Ingredient saved succesfully'
        format.html { redirect_to recipe_url(@recipe) }
        format.json { render :show, status: :created, location: @recipe }
      else
        flash[:error] = 'Error: Ingredient could not be saved'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe_food.destroy

    flash[:success] = 'Recipe food has been deleted successfully'
    redirect_to recipe_url(@recipe.id)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :value)
  end

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
    @foods = current_user.foods
  end

  def set_recipe_food
    @recipe_food = RecipeFood.find_by(food_id: params[:id])
  end

  def ingredient_params
    params.require(:recipe_food).permit(:quantity)
  end
end
