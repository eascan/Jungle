require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'validates that product has all four fields set' do
      @category = Category.new(name: 'Naruto')
      @category.save!
      @product = @category.products.create!(name: 'Sasuke', price: 30, quantity: 4, category: @category)
      @product.save
      expect(@product).to be_valid
    end
    it 'shows as invalid without name input' do
      @category = Category.new(name: 'Naruto')
      @category.save!
      @product = @category.products.create(name: nil, price: 30, quantity: 4, category: @category)
      @product.save
      expect(@product.errors.full_messages).not_to be_empty
      expect(@product).to_not be_valid   
    end

    it 'shows as invalid without price' do
      @category = Category.new(name: 'Naruto')
      @category.save!
      @product = @category.products.create(name: 'Sasuke', price: nil, quantity: 4, category: @category)
      @product.save
      expect(@product.errors.full_messages).not_to be_empty
      expect(@product).to_not be_valid       
    end
    it 'shows as invalid without quantity' do
      @category = Category.new(name: 'Naruto')
      @category.save!
      @product = @category.products.create(name: 'Sasuke', price: 30, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).not_to be_empty
      expect(@product).to_not be_valid       
    end

    it 'shos as invalid without category' do
      @product = Product.new(name: 'Sasuke', price: 30, quantity: 4, category: nil )
      @product.save
      expect(@product.errors.full_messages).not_to be_empty
      expect(@product).to_not be_valid
    end

  end
end