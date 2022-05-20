require 'rails_helper'

RSpec.describe 'Food index page', type: :system do
  before do
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
  end

  describe 'Visiting the food index page' do
    before :each do
      visit new_user_session_path
      fill_in 'Email', with: 'first@email.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      click_link 'Public Recipes'
    end

    it 'should display the public recipes' do
      expect(page).to have_content('Gallo Pinto')
    end

    it 'should redirect to public recipes page' do
      expect(page.current_path).to have_content('/public_recipes')
    end

    it 'should display Create Recipe button' do
      expect(page).to have_link('Create Recipe')
    end

    it 'should display the Total food items text' do
      expect(page).to have_content('Total food items: 0')
    end
  end
end
