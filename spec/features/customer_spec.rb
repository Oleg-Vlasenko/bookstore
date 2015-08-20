require 'features/features_spec_helper'

feature 'Аuthentication user' do
  create_current_customer
  create_books
  
  before(:each) do
  end

  scenario 'Register new customer' do
    visit new_customer_path
    
    fill_in 'customer_email', with: 'newbee@gmail.com'
    fill_in 'customer_first_name', with: 'Gina'
    fill_in 'customer_last_name', with: 'Carano'
    fill_in 'customer_password', with: 'psw555'
    fill_in 'customer_password_confirmation', with: 'psw555'
    
    click_button 'Register'
    
    expect(page).to have_selector('[speclabel="add-to-cart"]')
  end
  
  scenario 'Edit customer settings' do
    sign_in
    visit settings_path
    
    expect(page).to have_selector("form#edit_customer_#{customer_id}")
  end

end
