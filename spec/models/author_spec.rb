require 'rails_helper'

RSpec.describe Author, :type => :model do
  # first_name, last_name fields should be required
  # Should have many books

  let(:author) { FactoryGirl.create(:author) }

  context 'validates' do
    it 'first_name should be required' do
      expect(author).to validate_presence_of(:first_name)
    end

    it 'last_name should be required' do
      expect(author).to validate_presence_of(:last_name)
    end
  end

  context 'associations' do
    it 'author should have many books' do
      expect(author).to have_many(:books)
    end
  end

  context 'functionality' do
    it 'author should return self name' do
      expect(author.name).to eq(author.first_name + ' ' + author.last_name)
    end
  end
end
