require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

  
    it "name present?" do
      @category = Category.new(name: "test")
      @product = Product.new(name: "product_test", price: 100, quantity: 2, category: @category)
      @product.save
      expect(@product.name).to be_present
    end

    it "price present?" do
      @category = Category.new(name: "test")
      @product = Product.new(name: "product_test", quantity: 2, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "quantity present?" do
      @category = Category.new(name: "test")
      @product = Product.new(name: "product_test", price: 100, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "category present?" do
      @category = Category.new(name: "test")
      @product = Product.new(name: "product_test", price: 100, quantity: 2, category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
