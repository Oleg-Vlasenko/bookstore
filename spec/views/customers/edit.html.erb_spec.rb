require 'rails_helper'

RSpec.describe "customers/edit.html.erb", :type => :view do
  context 'new customer form' do
    let(:b_a) { mock_model('BillingAddress',
                      first_name: nil,
                      last_name: nil,
                      address: nil,
                      city: nil,
                      country_id: nil,
                      zip_code: nil,
                      phone: nil) }
                      
    let(:s_a) { mock_model('ShippingAddress',
                      first_name: nil,
                      last_name: nil,
                      address: nil,
                      city: nil,
                      country_id: nil,
                      zip_code: nil,
                      phone: nil) }

    let(:customer) { mock_model('Customer', 
                      billing_address: b_a, 
                      shipping_address: s_a,
                      first_name: nil, 
                      last_name: nil, 
                      email: nil, 
                      password:nil, 
                      password_confirmation: nil) }

    before(:each) do
      assign(:customer, customer)
      render
    end

    it 'renders form' do
      expect(rendered).to have_selector('form')
    end

    it 'renders billing address settings' do
      # p 'INFO'
      # p customer.billing_address
      # p 'ENDINFO'
      
      expect(rendered).to have_selector('#customer_billing_address_id')
    end

    it 'renders shipping address settings' do
      expect(rendered).to have_selector('#customer_shipping_address_id')
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

    it 'renders current password' do
      expect(rendered).to have_selector('#password_current')
    end

    it 'renders new password' do
      expect(rendered).to have_selector('#password_new')
    end
  end
end
