require 'rails_helper'

RSpec.describe Customer, :type => :model do
  # Rewrite tests for authenticate functionality
  # Email, password, first_name, last_name fields should be required
  # Email should be unique
  # Should have many orders, ratings
  # A customer should be able to create a new order
  # A customer should be able to return a current order in progress

  let(:customer) { FactoryGirl.build(:customer) }

  context 'validates' do
    it 'email should be valid email' do
      expect(customer.email).to match(/\A.+@.+\..+\z/)
    end

    it 'email should be unique' do
      expect(customer).to validate_uniqueness_of(:email)
    end

    it 'first_name should be required' do
      expect(customer).to validate_presence_of(:first_name)
    end

    it 'last_name should be required' do
      expect(customer).to validate_presence_of(:last_name)
    end
  end

  context 'associations' do
    it 'customer should have many orders' do
      expect(customer).to have_many(:orders)
    end

    it 'customer should have many reviews' do
      expect(customer).to have_many(:reviews)
    end
  end

  context 'functionality' do
    it 'customer should return self name' do
      expect(customer.name).to eq(customer.first_name + ' ' + customer.last_name)
    end

    it 'customer should be able to create a new order' do
      new_order = customer.get_current_order!
      expect(new_order).to be_an_instance_of(Order)
    end

    it 'customer should be able to return a current order in progress' do
      current_order = customer.get_current_order!
      expect(current_order.state).to eq('in_progress')
    end
    
  end
end
