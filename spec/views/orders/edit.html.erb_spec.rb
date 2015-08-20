require 'rails_helper'

RSpec.describe "orders/edit.html.erb", :type => :view do
  
  let(:book) { mock_model('Book',
                          title: nil,
                          description: nil,) }
  
  let(:order_items) do
    oi = []
    2.times do
      oi << mock_model('OrderItem', 
                      book: book,
                      price: 5,
                      quantity: 1,
                      total_sum: 5)
    end
    oi
  end
  
  let(:order) { mock_model('Order', 
                          items: order_items,
                          subtotal_price: 10) }

  before(:each) do
    assign(:order, order)
    render
  end
  
  it 'renders order items' do
    expect(rendered).to have_selector('[speclabel="order-item"]')
  end

  it 'renders subtotal price' do
    expect(rendered).to have_selector('[speclabel="subtotal-price"]')
  end
  
  it 'renders empty cart button' do
    expect(rendered).to have_selector('[speclabel="empty-cart"]')
  end
  
  it 'renders continue shopping button' do
    expect(rendered).to have_selector('[speclabel="continue-shopping"]')
  end
  
  it 'renders update button' do
    expect(rendered).to have_selector('[speclabel="update"]')
  end
  
  it 'renders checkout button' do
    expect(rendered).to have_selector('[speclabel="checkout"]')
  end
  
end
