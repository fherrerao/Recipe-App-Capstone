require 'rails_helper'

RSpec.describe 'Recipes index', type: :system do
  describe 'Show recipes' do
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
      visit recipes_path
    end

    it 'should display recipes index page' do
      expect(page).to have_content('Recipes Index')
    end

    it 'should display the name of the recipe' do
      expect(page).to have_content('Gallo Pinto')
    end

    it 'should display the description of the recipe' do
      expect(page).to have_content('Traditional costarrican dish')
    end

    it 'should find a create recipe button' do
      expect(page).to have_link('Create Recipe')
    end

    it 'should find a create recipe button' do
      expect(page).to have_button('Delete recipe')
    end

    it 'should remove a recipe' do
      click_button 'Delete recipe'
      expect(page).to have_content('Recipe has been deleted successfully')
    end
  end
end
