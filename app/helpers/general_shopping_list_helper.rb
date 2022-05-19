module GeneralShoppingListHelper
  @@shopping = [] 
  def getShopping
    @@shopping
  end

  def addShopping    
    # if Recipe.find(params[:recipe]).recipe_foods
    @@shopping.push(*Recipe.find(params[:recipe]).recipe_foods)    
  end
end
