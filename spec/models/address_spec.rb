require 'rails_helper'

RSpec.describe Address, :type => :model do
  # All fields should be required
  # link to country

  let(:address) { FactoryGirl.build(:address) }

  context 'validates' do
    it 'address should be required' do
      expect(address).to validate_presence_of(:address)
    end
    
    it 'phone should be required' do
      expect(address).to validate_presence_of(:phone)
    end

    it 'zip_code should be required' do
      expect(address).to validate_presence_of(:zip_code)
    end

    it 'city should be required' do
      expect(address).to validate_presence_of(:city)
    end

    it 'country should be required' do
      expect(address).to validate_presence_of(:country)
    end

  end

  context 'associations' do
    it 'address should belong to country' do
      expect(address).to belong_to(:country)
    end

  end
end
