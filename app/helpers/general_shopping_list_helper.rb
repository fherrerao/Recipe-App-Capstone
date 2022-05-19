module GeneralShoppingListHelper
  # rubocop:disable Style/ClassVars
  @@shopping = []
  def getting_shopping
    @@shopping
  end

  def add_shopping
    @@shopping.push(*Recipe.find(params[:recipe]).recipe_foods)
  end
  # rubocop:enable Style/ClassVars
end
