require 'rails_helper'

RSpec.describe 'Shopping list', type: :system do
  describe 'Show food in the shopping list' do
    before :each do
      User.destroy_all
      Food.destroy_all
      Recipe.destroy_all
      RecipeFood.destroy_all
      @user = User.new(name: 'Billy', email: 'first@email.com', password: '123456',
                       password_confirmation: '123456')
      @user.skip_confirmation!
      @user.save

      @food = Food.new(name: 'Rice', measurement_unit: 'grams', price: 1.2, user: @user)
      @food.save
      visit new_user_session_path
      fill_in 'Email', with: 'first@email.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      @recipe = Recipe.create!(name: 'Gallo Pinto', preparation_time: 4.5, cooking_time: 8,
                               description: 'Traditional costarrican dish', public: true, user: @user)
      @recipe.save
      @recipe_food = RecipeFood.create!(quantity: 2.1, recipe: @recipe, food: @food)
      @recipe_food.save
    end

    it 'Display shoppong list page' do
      visit general_shopping_list_index_path
      expect(page).to have_content('Shopping List')
    end

    it 'should display the amount of items' do
      click_link 'My Recipes'
      click_on @recipe.name
      click_button 'Generate Shopping List'
      expect(page).to have_content('Amount of food items to buy: 1')
      expect(page).to have_content('Total value of food needed: $2.52')
    end
  end
end
