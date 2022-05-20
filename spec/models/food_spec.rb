require 'rails_helper'

RSpec.describe 'Food' do
  describe 'validations' do
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
    end

    it 'is valid with valid attributes' do
      expect(@food).to be_valid
    end

    it 'is not valid without a name' do
      @food.name = nil
      expect(@food).to_not be_valid
    end

    it 'is not valid without a measurement_unit' do
      @food.measurement_unit = nil
      expect(@food).to_not be_valid
    end

    it 'is not valid if the price is smaller than 0' do
      @food.price = -10
      expect(@food).to_not be_valid
    end

    it 'price should accept decimal values' do
      @food.price = 10.3
      expect(@food).to be_valid
    end

    it 'is not valid without a price' do
      @food.price = nil
      expect(@food).to_not be_valid
    end
  end
end
