module RecipesHelper
  def my_recipes
    current_user.recipes
  end
end
