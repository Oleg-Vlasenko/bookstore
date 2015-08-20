require 'rails_helper'

RSpec.describe "orders/index.html.erb", :type => :view do

  let(:book) { 
    mock_model('Book',
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
  
  let(:order) { 
    mock_model('Order',
      items: order_items,
      subtotal_price: 10,
      completed_date: DateTime.now,
      total_price: 100) }
  
  let(:completed_orders) { [order] }
  
  let(:shipped_orders) { [order] }

  before(:each) do
    assign(:order, order)
    assign(:completed_orders, completed_orders)
    assign(:shipped_orders, shipped_orders)
    render
  end
  
  it 'renders current order' do
    expect(rendered).to have_selector('[speclabel="order"]')
  end
  
  it 'renders current order items' do
    expect(rendered).to have_selector('[speclabel="order_item"]')
  end
  
  it 'renders completed orders' do
    expect(rendered).to have_selector('[speclabel="completed_orders"]')
  end
  
  it 'renders shipped orders' do
    expect(rendered).to have_selector('[speclabel="shipped_orders"]')
  end
  
end
