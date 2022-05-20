require 'rails_helper'

RSpec.describe 'Recipes show', type: :system do
  describe 'should display recipes in the page' do
    before :each do
      User.destroy_all
      Food.destroy_all
      Recipe.destroy_all

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
      visit recipe_path(@recipe.id)
    end

    it 'should display recipes show page' do
      expect(page).to have_content('Recipes Show')
    end

    it 'should display the name of the recipe food' do
      expect(page).to have_content('Gallo Pinto')
    end

    it 'should display the preparation time of the recipe food' do
      expect(page).to have_content('Preparation Time: 4.5 minutes')
    end

    it 'should display the cooking time of the recipe food' do
      expect(page).to have_content('Cooking Time: 8.0 minutes')
    end

    it 'should display Add ingredient button' do
      expect(page).to have_link('Add ingredient')
    end

    it 'should display public switch' do
      expect(page).to have_content('Public')
    end

    it 'should redirect to add ingredients page when press add ingredient button' do
      click_link 'Add ingredient'
      expect(page.current_path).to have_content("/recipes/#{@recipe.id}/recipe_foods/new")
    end
  end
end
