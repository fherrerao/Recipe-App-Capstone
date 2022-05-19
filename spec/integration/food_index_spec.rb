require 'rails_helper'
RSpec.describe 'Food', type: :system do 
  before(:all) do
    User.destroy_all    
    @user = User.new(name: 'Billy', email: 'first@email.com', :password => '123456', :password_confirmation => '123456')
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

  it 'should display the list of foods' do        
    visit new_user_session_path     
    fill_in 'Email', with: 'first@email.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content 'Foods'
  end

  it 'should create a new food' do
    visit new_food_path
    fill_in 'Email', with: 'first@email.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'    
    
    fill_in 'Name', with: 'Rice'
    fill_in 'Measurement unit', with: 'grams'
    fill_in 'Price', with: 1.2
    click_button 'Submit'
    expect(page).to have_content 'Food was successfully created.'
  end

  it 'should delete a food' do
    visit foods_path
    fill_in 'Email', with: 'first@email.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    click_button 'Delete food'
    expect(page).to have_content 'Food was successfully destroyed.'
  end
end
