class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :destroy]

  def index 
    @recipes = Recipe.all
  end

  def show; end

  def destroy
    @recipe.destroy

    flash[:success] = 'Post has been deleted successfully'
    redirect_to recipes_url
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
