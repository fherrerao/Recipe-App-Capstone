class RecipesController < ApplicationController
  include RecipesHelper
  load_and_authorize_resource
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :set_recipe_two, only: %i[edit_two]
  before_action :set_other_recipe, only: :update_two

  def index
    @page_title = 'Recipes Index'
    @recipes = my_recipes
  end

  def show; end

  def show_public
    @page_title = 'Public Recipes Index'
    @recipes = Recipe.includes(:user).all.where(public: true).order('created_at DESC')
  end

  def new
    @recipe = Recipe.new
  end

  def edit_two
    @food = Food.new
    @recipe_food = RecipeFood.new
  end

  def update_two
    @food = Food.new(food_params)
    @recipe_food = RecipeFood.new(ingredient_params)
    @food.user = current_user
    respond_to do |format|
      if @food.save
        @recipe_food.recipe = @recipe
        @recipe_food.food = @food
        @recipe_food.save
        flash[:success] = 'Food was successfully added to recipe.'
        format.html { redirect_to recipe_url(@recipe) }
        format.json { render :show, status: :created, location: @food }
      else
        flash[:error] = 'Error: Food could not be added to recipe.'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      if @recipe.save
        flash[:success] = 'Recipe saved succesfully'
        format.html { redirect_to recipe_url(@recipe) }
        format.json { render :show, status: :created, location: @recipe }
      else
        flash[:error] = 'Error: Recipe could not be saved'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        flash[:success] = 'Recipe has been updated successfully'
        format.html { redirect_to recipe_url(@recipe) }
        format.json { render :show, status: :ok, location: @recipe }
      else
        flash[:error] = 'Error: Recipe could not be updated'
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy

    flash[:success] = 'Recipe has been deleted successfully'
    redirect_to recipes_url
  end

  private

  def set_recipe
    @recipe = Recipe.includes(:recipe_foods, recipe_foods: :food).find(params[:id])
  end

  def set_recipe_two
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end

  def ingredient_params
    params.require(:recipe_food).permit(:quantity)
  end

  def set_other_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
