require 'rails_helper'

RSpec.describe Category, :type => :model do
  # Title should be required and unique
  # Should have many books

  let(:category) { FactoryGirl.create(:category) }

  context 'validates' do
    it 'title should be required' do
      expect(category).to validate_presence_of(:title)
    end

    it 'category should be unique' do
      expect(category).to validate_uniqueness_of(:title)
    end
  end

  context 'associations' do
    it 'category should have many books' do
      expect(category).to have_many(:books)
    end

  end
end
