module GeneralShoppingListHelper
  @@shopping = []
  def getting_shopping
    @@shopping
  end

  def add_shopping    
    @@shopping.push(*Recipe.find(params[:recipe]).recipe_foods)
  end
end
