class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  def reduced_description
    return description if description.length < 100

    "#{description[0, 100]}..."
  end
end
