class GeneralShoppingListController < ActionController::Base
  include GeneralShoppingListHelper
  def index
    # @ingredients = Recipe.joins("INNER JOIN recipe_foods ON recipe_foods.recipe_id = recipes.id INNER JOIN foods ON foods.id = recipe_foods.food_id ")   
    # @foods = Food.all
    # @ingredients = @foods.select('foods.name', 'foods.price')
    # @ingredients.each do |ingredient|
    #   puts "current_user: #{ingredient.name}"
    #   puts "current_user: #{ingredient.price}"
    # end
    

    # @ingredients = current_user.foods.select('foods.id, foods.name,foods.price,
    #   foods.measurement_unit, sum(recipe_foods.quantity) as quantity_sum').joins(:recipe_foods).group('foods.id')
    
    @total_value = 0
    @total_ingredients = 0
    # @ingredients.each do |i|
    #   @total_value += i.price * i.quantity_sum
    #   @total_ingredients += 1
    # end    

    @ingredients=getShopping
    @ingredients.each do |i|
      puts Food.find(i.food_id).name
      puts @total_value += Food.find(i.food_id).price * i.quantity      
    end    
  end

  def update
    addShopping
    redirect_to general_shopping_list_index_path
  end

end
