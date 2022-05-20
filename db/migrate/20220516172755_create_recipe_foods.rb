class CreateRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_foods do |t|
      t.float :quantity
      t.belongs_to :recipe
      t.belongs_to :food

      t.timestamps
    end
  end
end
