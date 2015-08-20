require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  Ord = Order
  
  let(:order) { mock_model('Order', { id: '10' }) }
  let(:current_customer) { mock_model('Customer') }

  let(:oi1) { mock_model(OrderItem, { id: '1'} ) }
  let(:oi2) { mock_model(OrderItem,  { id: '2'} ) }
  let(:order_items) { [oi1, oi2] }

  before(:each) do
    allow(Customer).to receive(:find_by_id).and_return(current_customer)
    allow(current_customer).to receive(:get_current_order).and_return(order)
    allow(current_customer).to receive(:get_current_order!).and_return(order)
    allow(order).to receive(:items).and_return(order_items)
  end

  describe 'GET index' do
    before(:each) do
      allow(current_customer).to receive(:get_orders).and_return( {} )

      get :index
    end
    
    it 'assigns @order' do 
      expect(assigns[:order]).to eq(order)
    end

    it 'assigns @completed_orders' do 
      expect(assigns[:completed_orders]).to eq( {} )
    end

    it 'assigns @shipped_orders' do 
      expect(assigns[:shipped_orders]).to eq( {} )
    end

    it 'renders index template' do 
      expect(response).to render_template('index')
    end

  end

  describe 'GET show' do
    before(:each) do
      allow(Ord).to receive(:find_by_id).and_return(order)

      get :show, { id: '10'  }
    end

    it 'assigns @order' do
      expect(assigns[:order]).to eq(order)
    end
    
    it 'renders index template' do
      expect(response).to render_template('show')
    end
  end

  describe 'GET edit' do
    before(:each) do
      allow(current_customer).to receive(:cart_state).and_return(Customer.default_cart_state)
      get :edit , { id: order.id  }
    end

    it 'renders edit template' do
      expect(response).to render_template('edit')
    end
  end

  describe 'POST update' do
    before(:each) do
      allow(oi1).to receive(:quantity=)
      allow(oi2).to receive(:quantity=) 
      allow(oi1).to receive(:save)
      allow(oi2).to receive(:save) 

      put :update, { id: '10' }
    end

    it 'assigns @order' do
      expect(assigns[:order]).to eq(order)
    end
    
    it 'assigns order items' do
      expect(assigns[:order].items).to eq(order_items)
    end
    
    it 'redirects to order' do
      expect(response).to redirect_to(:order)
    end
  end
  
  describe 'POST empty_cart' do
    before(:each) do
      allow(order).to receive(:items).and_return(order_items)

      post :empty_cart, { id: '10' }
    end
    
    it 'assigns @order' do
      expect(assigns[:order]).to eq(order)
    end
    
    it 'redirects to root' do
      expect(response).to redirect_to(:root)
    end
  end
  
  describe 'POST new_item' do 
    before(:each) do
      allow(order).to receive(:add_book).and_return(oi1)
      allow(oi1).to receive(:valid?).and_return(true)
      
      post :new_item, { book_id: '1', quantity: 10 }
    end
    
    it 'assigns @order' do
      expect(assigns[:order]).to eq(order)
    end
    
    it 'renders edit template' do
      expect(response).to render_template('edit')
    end
  end

end