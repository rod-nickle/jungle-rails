require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'validates :product, valid: true' do
      @category = Category.create(name: "Trees")

      @product = Product.new(
        name: 'Palm Tree',
        price_cents: 10000,
        quantity: 10,
        category_id: @category.id
      )
      @product.save!
      expect(@product).to be_valid
    end
    
    it 'validates :name, presence: true' do
      @category = Category.create(name: "Trees")

      @product = Product.new(
        price_cents: 10000,
        quantity: 10,
        category_id: @category.id
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates :price, presence: true' do
      @category = Category.create(name: "Trees")

      @product = Product.new(
        name: "Palm Tree",
        quantity: 10,
        category_id: @category.id
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates :quantity, presence: true' do
      @category = Category.create(name: "Trees")

      @product = Product.new(
        name: "Palm Tree",
        price_cents: 10000,
        category_id: @category.id
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates :category, presence: true' do
      @category = Category.create(name: "Trees")

      @product = Product.new(
        name: "Palm Tree",
        price_cents: 10000,
        quantity: 10,
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
