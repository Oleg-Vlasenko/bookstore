require 'rails_helper'

RSpec.describe "orders/show.html.erb", :type => :view do
  
  let(:order_id) { '10' }
  let(:book_title) { 'Jungle book' }
  let(:book_price) { 5 }
  let(:book_qnt) { 1 }
  let(:book_sum) { 5 }
  let(:subtotal_price) { 90 }
  let(:shipping) { 10 }
  let(:total_price) { 100 }

  let(:book) { mock_model('Book',
                          title: book_title,
                          description: nil,) }
  
  let(:order_items) do
    oi = []
    2.times do
      oi << mock_model('OrderItem', 
                      book: book,
                      price: book_price,
                      quantity: book_qnt,
                      total_sum: book_sum)
    end
    oi
  end

  let(:order) { mock_model('Order',
    id: order_id,
    items: order_items,
    subtotal_price: subtotal_price,
    shipping: shipping,
    total_price: total_price,
    state: 'completed') }
  
  before(:each) do
    assign(:order, order)
    render
  end

  it 'renders order' do
    expect(rendered).to have_selector('[speclabel="order"]', "Order R#{"%08d" % order_id}")
  end 
  
  it 'renders orders books' do
    expect(rendered).to have_selector('[speclabel="order-item"]')
  end
  
  it 'renders book title' do
    expect(rendered).to have_selector('[speclabel="book-title"]', book_title)
  end

  it 'renders book price' do
    expect(rendered).to have_selector('[speclabel="book-price"]', '%.2f' % book_price.to_f)
  end
    
  it 'renders order item quantity' do
    expect(rendered).to have_selector('[speclabel="book-qnt"]', book_qnt)
  end
  
  it 'renders order item total sum' do
    expect(rendered).to have_selector('[speclabel="book-sum"]', '%.2f' % book_sum.to_f)
  end
  
  it 'renders subtotal sum' do
    expect(rendered).to have_selector('[speclabel="subtotal-price"]', '%.2f' % subtotal_price.to_f)
  end
  
  it 'renders shipping sum' do
    expect(rendered).to have_selector('[speclabel="shipping-sum"]', '%.2f' % shipping.to_f)
  end
  
  it 'renders total sum' do
    expect(rendered).to have_selector('[speclabel="total-price"]', '%.2f' % total_price.to_f)
  end
  
end
