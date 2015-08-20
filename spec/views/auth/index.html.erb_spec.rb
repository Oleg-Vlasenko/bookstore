require 'rails_helper'

RSpec.describe "auth/index.html.erb", :type => :view do
  context 'authenticate form' do
    # mock Customer doesn't handle authenticate errors
    # let(:customer) { mock_model('Customer') }
    let(:customer) { Customer.new }

    before(:each) do
      assign(:customer, customer)
      customer.errors.add(:email, 'wrong email')
      render
    end

    it 'renders authenticate errors' do
      expect(rendered).to have_selector('#error_explanation')
    end

    it 'renders form' do
      expect(rendered).to have_selector('#auth-form')
    end

    it 'renders customer\'s email' do
      expect(rendered).to have_selector('#email')
    end

    it 'renders password' do
      expect(rendered).to have_selector('#password')
    end
  end
end
