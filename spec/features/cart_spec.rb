require 'features/features_spec_helper'

feature 'Cart' do
  create_current_customer
  create_books
  fill_cart
  
  let(:book) { books[0] }

  before(:each) do
    sign_in
  end
  
  scenario 'Visitor add book to cart' do
    visit book_path(book.id)
    
    fill_in 'books_amount', with: 1
    click_button 'ADD TO CART'
    
    expect(page).to have_selector('h3', text: book.title)
  end

  scenario 'Visitor open cart' do
    visit cart_path
    
    expect(page).to have_selector('#order-table')
    expect(page).to have_selector('[speclabel="update"]')
  end
  
  scenario 'Visitor remove item' do #, :js => true do
    visit cart_path
    
    click_button 'X'
    click_button 'UPDATE'
    
    # disabled bacause selenium not run javascripts
    # expect(page).to have_selector('a', text: 'CART (EMPTY)')
  end
  
  scenario 'Visitor empty cart' do #, :js => true do
    visit cart_path

    # disabled bacause selenium not run javascripts
    # click_button 'EMPTY CART'
    # expect(page).to have_selector('a', text: 'CART (EMPTY)')
  end
  
  scenario 'Visitor change book quantity' do
    visit cart_path
    
    @item1_id = customer.get_current_order.items[0].id
    @item1_tag_id = "item_#{@item1_id}_qty"
    
    fill_in @item1_tag_id, with: 2
    click_button 'UPDATE'

    visit cart_path

    expect(page).to have_selector("##{@item1_tag_id}", exact: '2')
  end
  
end
