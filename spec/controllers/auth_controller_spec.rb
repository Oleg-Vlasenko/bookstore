require 'rails_helper'

RSpec.describe AuthController, :type => :controller do
  let(:customer) { mock_model('Customer') }

  describe 'GET index' do
    before(:each) do
      allow(Customer).to receive(:new).and_return(customer)
      get :index
    end

    it'assigns @customer' do
      expect(assigns[:customer]).to eq(customer)
    end

    it 'renders index template' do
      expect(response).to render_template('index')
    end
  end
  
  describe 'POST sign_in' do
    before(:each) do
      allow(Customer).to receive(:find_by).with(email: 'test@test.org').and_return(customer)
      allow(customer).to receive(:authenticate).with('test').and_return(true)

      post :sign_in, { email: 'test@test.org', password: 'test' }
    end
    
    it 'assigns @customer' do 
      expect(assigns[:customer]).to eq(customer)
    end
    
    it 'redirects to root if customer is authenticated' do
      expect(response).to redirect_to(:root)
    end
  end

  describe 'GET sign_out' do 
    before(:each) do
      get :sign_out
    end

    it 'set current_customer to nil' do 
      expect(assigns[:current_customer]).to eq(nil)
    end
    
    it 'redirects to root' do
      expect(response).to redirect_to(:root)
    end
  end

end