require 'rails_helper'

RSpec.describe Country, :type => :model do
  # Name should be required and unique

  let(:country) { FactoryGirl.build(:country) }

  context 'validates' do
    it 'name should be required' do
      expect(country).to validate_presence_of(:name)
    end

    it 'name should be unique' do
      expect(country).to validate_uniqueness_of(:name)
    end

  end

end
