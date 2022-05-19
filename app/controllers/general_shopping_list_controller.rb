class GeneralShoppingListController < ActionController::Base
  include GeneralShoppingListHelper

  layout 'application'
  
  def index    
    @ingredients=getShopping
    @total_value = 0
    @total_ingredients = 0
    @ingredients.each do |i|      
      @total_value += Food.find(i.food_id).price * i.quantity      
    end    
  end

  def update
    addShopping
    redirect_to general_shopping_list_index_path
  end

end
