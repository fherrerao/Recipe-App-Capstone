require 'rails_helper'

RSpec.describe 'Recipe' do
  before(:all) do
    User.destroy_all
    @user = User.new(name: 'Billy', email: 'first@email.com', password: '123456',
                     password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save
  end

  before(:each) do
    @food = Food.new(name: 'Rice', measurement_unit: 'grams', price: 1.2, user: @user)
    @food.save
    @recipe = Recipe.create!(name: 'Gallo Pinto', preparation_time: 4.5, cooking_time: 8,
                             description: 'Traditional costarrican dish', public: true, user: @user)
    @recipe.save
  end

  it 'is valid with valid attributes' do
    expect(@recipe).to be_valid
  end

  it 'is not valid without a name' do
    @recipe.name = nil
    expect(@recipe).to_not be_valid
  end

  it 'is not valid without a description' do
    @recipe.description = nil
    expect(@recipe).to_not be_valid
  end

  it 'should be valid with preparation_time bigger than 0' do
    @recipe.preparation_time = 10
    expect(@recipe).to be_valid
  end

  it 'is not valid if the preparatio_time is smaller than 0' do
    @recipe.preparation_time = -10
    expect(@recipe).to_not be_valid
  end

  it 'preparation_time should accept decimal values' do
    @recipe.preparation_time = 10.53
    expect(@recipe).to be_valid
  end

  it 'should be valid with cooking_time bigger than 0' do
    @recipe.cooking_time = 10
    expect(@recipe).to be_valid
  end

  it 'is not valid if the cooking_time is smaller than 0' do
    @recipe.cooking_time = -10
    expect(@recipe).to_not be_valid
  end

  it 'cooking_time should accept decimal values' do
    @recipe.cooking_time = 10.53
    expect(@recipe).to be_valid
  end

  it 'description should accept maximunm 1000 characters' do
    @recipe.description = 'a' * 1001
    expect(@recipe).to_not be_valid
  end
end
