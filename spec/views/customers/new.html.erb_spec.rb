require 'rails_helper'

RSpec.describe "customers/new.html.erb", :type => :view do
  context 'new customer form' do
    let(:customer) { mock_model('Customer', first_name: nil, last_name: nil, email: nil, password:nil, password_confirmation: nil) }

    before(:each) do
      assign(:customer, customer)
      render
    end

    it 'renders form' do
      expect(rendered).to have_selector('form')
    end

    it 'renders customer\'s email' do
      expect(rendered).to have_selector('#customer_email')
    end

    it 'renders first name' do
      expect(rendered).to have_selector('#customer_first_name')
    end

    it 'renders last name' do
      expect(rendered).to have_selector('#customer_last_name')
    end

    it 'renders password' do
      expect(rendered).to have_selector('#customer_password')
    end

    it 'renders password confirmation' do
      expect(rendered).to have_selector('#customer_password_confirmation')
    end
  end
end
