require 'rails_helper'

RSpec.describe "shop/home", :type => :view do
  let(:author) { mock_model('Author', name: Faker::Name.name) }
  let(:book) { mock_model('Book',
                          id: '3',
                          title: Faker::Lorem.word,
                          author: author,
                          price: Random.rand(1..10),
                          description: Faker::Lorem.word) }

  let(:prev_id) {'2'}
  let(:next_id) {'4'}

  before(:each) do
    assign(:book, book)
    assign(:prev_id, prev_id)
    assign(:next_id, next_id)

    render
  end

  it 'renders book title' do
    expect(rendered).to have_selector('#book-title', text: book.title)
  end

  it 'renders book author' do
    expect(rendered).to have_selector('#author-name', text: author.name)
  end

  it 'renders book description' do
    expect(rendered).to have_selector('#book-description', text: book.description)
  end

  it 'renders book price' do
    expect(rendered).to have_selector('#book-price', text: book.price)
  end

  it 'renders previous book link' do
    expect(rendered).to have_link('prev-book', href: home_path(id: prev_id))
  end

  it 'renders next book link' do
    expect(rendered).to have_link('next-book', href: home_path(id: next_id))
  end
end
