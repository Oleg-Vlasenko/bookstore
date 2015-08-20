require 'rails_helper'
require 'capybara/rspec'

def create_current_customer
  given!(:country) { FactoryGirl.create(:country) }
  given!(:billing_address) { FactoryGirl.create(:billing_address, {
    country: country
  }) }
  given!(:shipping_address) { FactoryGirl.create(:shipping_address, {
    country: country
  }) }
  
  given!(:customer_id) { 5 }
  given!(:customer) { FactoryGirl.create(:customer, { 
    id: customer_id, 
    email: 'jdoe@gmail.com', 
    first_name: 'John', 
    last_name: 'Doe', 
    password: '1', 
    billing_address: billing_address,
    shipping_address: shipping_address
  }) }
end

def create_books
  given!(:books) { FactoryGirl.create_list(:book, Paginate.books_on_page*2) }
end

def fill_cart
  given!(:credit_card) { FactoryGirl.create(:credit_card, { customer: customer }) }
  # customer.credit_card = credit_card
  given!(:order) { FactoryGirl.create(:order, {
    customer: customer,
    state: Order.states[0],
    credit_card: credit_card,
    billing_address: billing_address,
    shipping_address: shipping_address }) }
  
  given!(:order_item) { FactoryGirl.create(:order_item, order: order, book: books[0]) }
end

def sign_in
  create_current_customer unless customer

  visit sign_in_path
  
  fill_in 'email', with: customer.email
  fill_in 'password', with: customer.password
  
  click_button 'Sign in'
end