require 'rails_helper'

RSpec.describe CustomersController, :type => :controller do

  let(:customer) { mock_model('Customer', id: 10, name: 'Phil') }
  let(:current_customer) { customer }

  describe 'GET new' do 
    before(:each) do
      allow(Customer).to receive(:new).and_return(customer)
      get :new
    end

    it 'assigns @customer' do
      expect(assigns[:customer]).to eq(customer)
    end
    
    it 'renders new template' do
      expect(response).to render_template('new')
    end
  end
  
  describe 'GET edit' do 
    before(:each) do
      allow(Customer).to receive(:find_by_id).and_return(customer)
      allow(customer).to receive(:init_addresses)
      
      get :edit
    end

    it 'assigns @customer' do
      expect(assigns[:customer]).to eq(customer)
    end
    
    it 'renders edit template' do
      expect(response).to render_template('edit')
    end
  end
  
  describe 'POST create' do 
    before(:each) do
      allow(Customer).to receive(:new).and_return(customer)
      allow(customer).to receive(:save).and_return(true)
      post :create, {customer: {param1: nil}}
    end

    it 'creates customer with post params' do
      expect(assigns[:customer]).to eq(customer)
    end
    
    it 'redirects to root if customer is created' do
      expect(response).to redirect_to(:root)
    end
  end

end
