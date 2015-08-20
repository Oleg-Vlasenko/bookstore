require 'rails_helper'

RSpec.describe Review, :type => :model do
  # rating should be from one to five
  # Should belong to customer and book

  let(:review) { FactoryGirl.build(:review) }

  context 'validates' do
    it 'rating should be from one to five' do
      expect(review).to validate_numericality_of(:rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5)
    end
  end

  context 'associations' do
    it 'review should belong to customer' do
      expect(review).to belong_to(:customer)
    end

    it 'review should belong to book' do
      expect(review).to belong_to(:book)
    end
  end

end
