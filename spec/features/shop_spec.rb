require 'features/features_spec_helper'

feature 'Show shop' do
  create_books
  
  before(:each) do
  end

  scenario 'Visitor open next shop page' do
    visit shop_path

    expect(page).to have_link('2', href: shop_path(page: '2'))
    click_link('2', href: shop_path(page: '2'))
    expect(page).to have_selector('span.book-title', text: books[Paginate.books_on_page].title)
  end

  scenario 'Visitor back to previous page' do
    visit shop_path(page: '2')

    expect(page).to have_selector('span.book-title', text: books[Paginate.books_on_page].title)
    click_link('1', href: shop_path(page: 1))
    expect(page).to have_link('2', href: shop_path(page: '2'))
  end
  
end
