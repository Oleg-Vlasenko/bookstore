require 'features/features_spec_helper'

feature 'Аuthentication user' do
  create_current_customer
  create_books

  scenario 'Visitor open sign in page' do
    visit home_path
    click_link('Sign in')

    expect(page).to have_selector('#email')
    expect(page).to have_selector('#password')
  end
  
  scenario 'Visitor sign in to store' do 
    visit sign_in_path
    
    fill_in 'email', with: 'jdoe@gmail.com'
    fill_in 'password', with: '1'
    click_button 'Sign in'

    expect(page).to have_selector('[speclabel="add-to-cart"]')
  end
  
  scenario 'Visitor sign out from store' do
    visit sign_in_path
    
    fill_in 'email', with: 'jdoe@gmail.com'
    fill_in 'password', with: '1'
    click_button 'Sign in'

    click_link 'Sign out'
    
    expect(page).to have_selector('a', text: 'Sign in')
    expect(page).to_not have_selector('a', text: 'Sign out')
  end
  
end
