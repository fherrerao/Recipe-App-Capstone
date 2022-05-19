class RecipesController < ApplicationController
  include RecipesHelper
  load_and_authorize_resource
  before_action :set_recipe, only: %i[show edit edit_two update destroy]
  before_action :set_other_recipe, only: :update_two

  def index
    @page_title = 'Recipes Index'
    @recipes = my_recipes
  end

  def show; end

  def show_public
    @page_title = 'Public Recipes Index'
    @recipes = Recipe.all.where(public: true)
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
        format.html { redirect_to recipe_url(@recipe), notice: 'Food was successfully added to recipe.' }
        format.json { render :show, status: :created, location: @food }
      else
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
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
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
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe\'s public state was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
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
