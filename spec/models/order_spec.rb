require 'rails_helper'

RSpec.describe Order, :type => :model do
  # Total price, completed date and state fields should be required
  # state (in progress/complited/shipped)
  # By default an order should have 'in progress' state
  # Should have many order items
  # Should have one billing address and one shipping address (в модели указать через имя класса, railsguide, p 4.2.2.)
  # Should belong to customer and credit card
  # An order should be able to add a book to the order
  # An order should be able to return a total price of the order

  let(:order) { FactoryGirl.build(:order) }

  context 'validates' do
    it 'completed date should be required if order is completed' do
      order.state = 'completed'
      expect(order).to validate_presence_of(:completed_date)
    end

    it 'state should be initialized before validation' do
      order.state = nil
      order.valid?
      expect(order.state).to eq('in_progress')
    end

    it 'state should be in_progress/completed/shipped states' do
      states = ['in_progress', 'completed', 'shipped']
      states.each do |state|
        order.state = state
        expect(order).to be_valid(:state)
      end

      order.state = 'no_valid_state'
      expect(order).not_to be_valid(:state)
    end
  end

  context 'initialization' do
    it 'order by default should have "in_progress" state' do
      default_state = 'in_progress'
      expect(order.state).to eq(default_state)
    end
  end

  context 'associations' do
    it 'order should have many order items' do
      expect(order).to have_many(:items)
    end

    it 'order should have one billing address' do
      expect(order).to belong_to(:billing_address)
    end

    it 'order should have one shipping address' do
      expect(order).to belong_to(:shipping_address)
    end

    it 'order should belong to customer' do
      expect(order).to belong_to(:customer)
    end

    it 'order should belong to credit card' do
      expect(order).to belong_to(:credit_card)
    end

  end

  context 'functionality' do
    it 'order should be able to return a total price of the order' do
      shipping = 10
      order.shipping = shipping
      order.save
      items_sum = 0
      2.times do
        book = FactoryGirl.build(:book)
        book.save
        quantity = 2
        order.add_book(book.id, quantity)
        items_sum += (book.price * quantity).round(2)
      end
      
      expect(order.total_price).to eq((items_sum + shipping).round(2))
    end

    it 'order should be able to add a book to the order' do
      order.save
      book = FactoryGirl.build(:book)
      book.save
      order.add_book(book.id, 1)
      
      expect(order.items.count).to eq(1)
    end

  end

end

