require 'rails_helper'

RSpec.describe "books/show", :type => :view do
  let (:author) { mock_model('Author', {name: Faker::Name.name}) }
  let (:current_customer) { mock_model('Customer', {name: Faker::Name.name}) }

  let(:reviews) do
    reviews = []
    2.times { reviews << mock_model('Review', {title: Faker::Lorem.sentence(2),
                                              customer: current_customer,
                                              rating: Random.rand(3..5),
                                              review_text: Faker::Lorem.sentence(4),
                                              created_at: DateTime.now}) }
    reviews
  end

  let(:book) { mock_model('Book', {title: Faker::Lorem.sentence(2),
                                   price: Random.rand(5..20),
                                   author: author,
                                   description: Faker::Lorem.sentence(4),
                                   reviews: reviews}) }
                                   

  before(:each) do
    assign(:book, book)
    assign(:current_customer, current_customer)

    render
  end

  context 'book data' do
    it 'renders book title' do
      expect(rendered).to have_selector('#book-title', text: book.title)
    end

    it 'renders book author' do
      expect(rendered).to have_selector('#author-name', text: author.name)
    end

    it 'renders book price' do
      expect(rendered).to have_selector('#book-price', text: book.price)
    end

    it 'renders book description' do
      expect(rendered).to have_selector('#book-description', text: book.description)
    end
  end

  context 'reviews' do
    it 'renders rating' do
      expect(rendered).to have_selector('.rating-bar > .rating-star.marked')
    end

    it 'renders review title' do
      expect(rendered).to have_selector('.review-title', text: reviews[0].title)
    end

    it 'renders review author' do
      expect(rendered).to have_selector('.review-author', text: reviews[0].customer.name)
    end

    it 'renders review date' do
      expect(rendered).to have_selector('.review-date', text: reviews[0].created_at.strftime("%b %d, %Y"))
    end

    it 'renders review' do
      expect(rendered).to have_selector('.review-review', text: reviews[0].review_text)
    end

    it 'renders link for adding new review' do
      expect(rendered).to have_selector('a.add-review')
    end
  end

  it 'renders "add to order" form' do
    expect(rendered).to have_selector('form > input#books_amount')
  end
end
