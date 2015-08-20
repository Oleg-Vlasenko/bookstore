require 'rails_helper'

RSpec.describe "shop/index", :type => :view do

  let(:books) do
    books = []
    Paginate.books_on_page.times do
      books << mock_model('Book', {title: Faker::Lorem.sentence(2), price: Random.rand(5..20)})
    end
    books
  end

  let(:categories) do
    categories = []
    5.times do
      categories << mock_model('Category', {title: Faker::Lorem.word})
    end
    categories
  end

  let(:paginate) do
    paginate = Paginate.new
    paginate.set_buttons(1, 12)
    paginate
  end

  before(:each) do
    assign(:books, books)
    assign(:categories, categories)
    assign(:paginate, paginate)

    render
  end

  it 'renders books table' do
    expect(rendered).to have_selector('#books-grid')
  end

  it 'renders name and price of each book on page' do
    books.each do |book|
      expect(rendered).to have_selector('span.book-title', text: book.title)
      expect(rendered).to have_selector('span.book-price', text: book.price)
    end
  end

  it 'renders pagination' do
    expect(rendered).to have_selector('ul.pagination')
  end

  it 'renders all categories' do
    categories.each do |category|
      expect(rendered).to have_selector('li.category', text: category.title)
    end
  end
end
