require 'features/features_spec_helper'

feature 'Show shop by category' do
  create_books
  
  before(:each) do
  end

  scenario 'Visitor open selected category' do
    visit shop_path

    click_link(Category.first.title)
    expect(page).to have_selector('.category-name', text: "Categories - #{Category.first.title}")
  end
  
  scenario 'Visitor back to all categories' do
    visit shop_by_ctg_path(ctg: 1)
    
    click_link('SHOP')
    expect(page).to have_selector('span.book-title', text: Book.first.title)
  end

end
