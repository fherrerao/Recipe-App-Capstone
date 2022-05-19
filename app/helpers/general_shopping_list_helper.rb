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
      # aqui no es
      @@shopping.push(*recipe_ingredients)
    end
  end
  # rubocop:enable Style/ClassVars

  private

  def find_not_repeated_ingredients(recipe_ingredients)
    not_repeated = []
    recipe_ingredients.each do |food|
      temp = []
      @@shopping.each do |ingredient|
        temp.push(food) if ingredient.food_id == food.food_id
      end
      not_repeated.push(food) if temp.empty?
    end
    not_repeated
  end

  def find_repeated_ingredients(recipe_ingredients)
    repeated = []
    recipe_ingredients.each do |food|
      array = @@shopping.select { |ingredient| ingredient.food_id == food.food_id }
      array.each do |element|
        repeated.push(element) unless repeated.include? element
      end
    end
    repeated
  end
end
