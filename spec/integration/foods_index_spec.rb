require 'rails_helper'
RSpec.describe 'Food', type: :system do
  before do
    User.destroy_all
    @user = User.new(name: 'Billy', email: 'first@email.com', password: '123456', password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save

    Food.destroy_all
    @food = Food.new(name: 'Rice', measurement_unit: 'grams', price: 1.2, user: @user)
    @food.save
  end

  it 'to visit the foods page you need to sign in first' do
    visit foods_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  describe 'show list of foods' do
    before :each do
      visit new_user_session_path
      fill_in 'Email', with: 'first@email.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
    end

    it 'should display the list of foods' do
      expect(page).to have_content 'Foods'
    end

    it 'should delete a food' do
      click_button 'Delete food'
      expect(page).to have_content 'Food has been destroyed successfully'
    end

    it "should display the foods's name" do
      expect(page).to have_text('Rice')
    end

    it "should display the food's measurement_unit" do
      expect(page).to have_text('grams')
    end

    it 'should have a new food button' do
      expect(page).to have_link('New food')
    end
  end
end
