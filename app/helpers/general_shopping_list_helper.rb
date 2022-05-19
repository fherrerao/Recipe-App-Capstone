module GeneralShoppingListHelper
  # rubocop:disable Style/ClassVars
  @@shopping = []
  def getting_shopping
    @@shopping
  end

  def add_shopping
    recipe_ingredients = Recipe.find(params[:recipe]).recipe_foods
    targets = find_repeated_ingredients(recipe_ingredients)
    if targets.any?
      @@shopping.each do |food|
        targets.each do |element|
          element.quantity += food.quantity if food.food_id == element.food_id
        end
      end
      not_repeated = find_not_repeated_ingredients(recipe_ingredients)
      @@shopping.push(*not_repeated)
    else
      @@shopping.push(*recipe_ingredients)
    end
  end
  # rubocop:enable Style/ClassVars

  private

  def find_not_repeated_ingredients(recipe_ingredients)
    not_repeated = []
    @@shopping.each do |ingredient|
      single = recipe_ingredients.reject { |food| ingredient.food_id == food.food_id }
      not_repeated.push(*single) unless not_repeated.include? single
    end
    not_repeated
  end

  def find_repeated_ingredients(recipe_ingredients)
    repeated = []
    recipe_ingredients.each do |food|
      single = @@shopping.select { |ingredient| ingredient.food_id == food.food_id }
      repeated.push(*single) unless repeated.include? single
    end
    repeated
  end
end
