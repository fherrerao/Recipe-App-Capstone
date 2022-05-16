class RecipeFood < ApplicationRecord
  belongs_to :foods
  belongs_to :recipes
end
