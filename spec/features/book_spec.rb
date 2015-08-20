require 'features/features_spec_helper'

feature 'Books' do
  create_current_customer
  create_books
  
  let(:book) { books[0] }

  before(:each) do
  end

  scenario 'Visitor open selected book page' do
    visit book_path(book.id)
    
    expect(page).to have_selector('#book-title', text: book.title)
  end
  
  scenario 'Visitor add new review' do
    sign_in
    visit new_book_review_path(book.id)

    @rev_title = 'Great!'
    @review = 'This is the best Linkolns biography.'
    fill_in 'title', with: @rev_title
    fill_in 'review', with: @review
    
    click_button 'ADD'

    expect(page).to have_selector('.review-title', text: @rev_title)
    expect(page).to have_selector('.review-author', text: "by #{customer.name}")
    expect(page).to have_selector('.review-review', text: @review)
  end
  
end
