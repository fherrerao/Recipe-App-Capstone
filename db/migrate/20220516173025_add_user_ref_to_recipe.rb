class AddUserRefToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :users, null: false, foreign_key: true
  end
end
