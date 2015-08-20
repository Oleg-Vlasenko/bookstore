require 'features/features_spec_helper'

feature 'Orders' do
  create_current_customer
  create_books
  fill_cart

  before(:each) do
    sign_in
  end
  
  scenario 'Visitor view orders list by status' do
    @completed = FactoryGirl.create_list(:order, 2, customer: customer, state: Order.states[1])
    @shipped = FactoryGirl.create_list(:order, 2, customer: customer, state: Order.states[2])
    
    visit orders_path
    
    expect(page).to have_selector('h3', text: 'IN PROGRESS')
    
    expect(page).to have_selector('h3', text: 'COMPLETED')
    expect(page).to have_selector('p', text: "R%08d" % @completed[0].id)

    expect(page).to have_selector('h3', text: 'SHIPPED')
    expect(page).to have_selector('p', text: "R%08d" % @shipped[0].id)
  end
  
  scenario 'Visitor view selected order' do
    @order = FactoryGirl.create(:order, customer: customer, state: Order.states[1])
    FactoryGirl.create(:order_item, order: @order, book: books[0])    
    visit order_path(@order.id)

    expect(page).to have_selector('[speclabel="order"]', text: "Order R%08d" % @order.id)
  end

end
