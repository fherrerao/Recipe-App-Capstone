require 'rails_helper'

RSpec.describe 'Login', type: :system do
  before :all do
    User.destroy_all
    @user = User.new(name: 'Billy', email: 'first@email.com', password: '123456', password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save
  end

  it 'should login succesfully' do
    visit root_path
    fill_in 'Email', with: 'first@email.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'should fail login if left the email' do
    visit root_path
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'should fail login if left the password' do
    visit root_path
    fill_in 'Email', with: 'first@email.com'
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end
end
