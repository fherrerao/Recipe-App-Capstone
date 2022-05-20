require 'rails_helper'

RSpec.describe 'Foods new', type: :system do
  before do
    User.destroy_all
    @user = User.new(name: 'Billy', email: 'first@email.com', password: '123456', password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save
  end

  describe 'Add new food' do
    before :each do
      visit new_food_path
      fill_in 'Email', with: 'first@email.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
    end

    it 'should create new food' do
      fill_in 'Name', with: 'Rice'
      fill_in 'Measurement unit', with: 'grams'
      fill_in 'Price', with: 1.2
      click_button 'Submit'
      expect(page).to have_content 'Food has been created successfully'
    end

    it 'should have name input field' do
      expect(page).to have_field('food_name')
    end

    it 'should have measurement unit  input field' do
      expect(page).to have_field('food_measurement_unit')
    end
    it 'should have price input field' do
      expect(page).to have_field('food_price')
    end

    it 'should have a add button' do
      expect(page).to have_button('Submit')
    end
  end
end
