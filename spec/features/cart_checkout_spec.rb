require 'features/features_spec_helper'

feature 'Cart checkout' do
  create_current_customer
  create_books
  fill_cart

  before(:each) do
    sign_in
  end
  
  scenario 'Visitor checkout cart' do
    visit cart_path
    
    click_link 'CHECKOUT'
    expect(page).to have_selector('h3', text: 'BILLING ADDRESS')
    expect(page).to have_selector('h3', text: 'SHIPPING ADDRESS')
  end
  
  scenario 'Visitor fill addresses' do
    customer.cart_state = Customer.cart_states[1]
    customer.save
    visit checkout_address_path

    @addr = '5th ave 727'
    fill_in 'order_billing_address_address', with: @addr
    click_button 'SAVE AND CONTINUE'
    
    @cart = customer.get_current_order
    expect(@cart.billing_address.address).to eq(@addr)
  end
  
  scenario 'Visitor select shipping variant' do
    customer.cart_state = Customer.cart_states[2]
    customer.save
    visit checkout_delivery_path
    
    page.choose'shipping_10'
    click_button 'SAVE AND CONTINUE'
    
    @cart = customer.get_current_order
    expect(@cart.shipping).to eq(10)
  end
  
  scenario 'Visitor fill credit card data' do
    customer.cart_state = Customer.cart_states[3]
    customer.save
    visit checkout_payment_path

    @card_number = 2806
    fill_in 'number', with: @card_number
    click_button 'SAVE AND CONTINUE'

    @cart = customer.get_current_order
    expect(@cart.credit_card.number).to eq(@card_number)
  end
  
  scenario 'Visitor confirm order' do
    customer.cart_state = Customer.cart_states[4]
    customer.save
    visit checkout_confirm_path
    
    expect(page).to have_selector('h5', text: order.billing_address.address)
    expect(page).to have_selector('h5', text: order.shipping_address.address)
    expect(page).to have_selector('h3', text: order_item.book.title)
  end
  
  scenario 'Visitor place order' do
    customer.cart_state = Customer.cart_states[4]
    customer.save
    visit checkout_confirm_path
    
    click_button 'PLACE ORDER'
    
    expect(page).to have_selector('h3', text: "Order R%08d" % order.id)
  end

end
