require 'rails_helper'

RSpec.describe OrderItem, :type => :model do
  # Price and quantity fields should be required
  # Should belong to book and order

  let(:order_item) { FactoryGirl.build(:order_item) }

  context 'validates' do
    it 'price should be required' do
      expect(order_item).to validate_presence_of(:price)
    end

    it 'price should be greater than zero' do
      expect(order_item).to validate_numericality_of(:price).is_greater_than(0)
    end

    it 'quantity should be required' do
      expect(order_item).to validate_presence_of(:quantity)
    end

    it 'quantity should be greater than zero' do
      expect(order_item).to validate_numericality_of(:quantity).is_greater_than(0)
    end

  end

  context 'associations' do
    it 'order_item should belong to book' do
      expect(order_item).to belong_to(:book)
    end

    it 'order_item should belong to order' do
      expect(order_item).to belong_to(:order)
    end
  end

end
