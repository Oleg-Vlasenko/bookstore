require 'rails_helper'

RSpec.describe CreditCard, :type => :model do
  # expiration_month, expiration_year range control in model
  # Should belong to customer and have many orders

  let(:credit_card) { FactoryGirl.build(:credit_card) }

  context 'validates' do
    it 'number should be required' do
      expect(credit_card).to validate_presence_of(:number)
    end

    it 'CVV should be required' do
      expect(credit_card).to validate_presence_of(:CVV)
    end

    it 'first_name should be required' do
      expect(credit_card).to validate_presence_of(:first_name)
    end

    it 'last_name should be required' do
      expect(credit_card).to validate_presence_of(:last_name)
    end


    it 'expiration_year and expiration_month should have range control' do
      credit_card.expiration_month = 20
      expect(credit_card).not_to be_valid(:expiration_month)

      credit_card.expiration_year = Date.today.prev_year.year
      expect(credit_card).not_to be_valid(:expiration_year)

      credit_card.expiration_year = Date.today.next_year.year
      credit_card.expiration_month = Random.rand(1..12)
      expect(credit_card).to be_valid(:expiration_month)
      expect(credit_card).to be_valid(:expiration_year)
    end

  end

  context 'associations' do
    it 'credit_card should have many orders' do
      expect(credit_card).to have_many(:orders)
    end

    it 'credit_card should belong to customer' do
      expect(credit_card).to belong_to(:customer)
    end

  end

end
