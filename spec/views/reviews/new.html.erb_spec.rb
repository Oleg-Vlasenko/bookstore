require 'rails_helper'

RSpec.describe "reviews/new", :type => :view do
  let(:book) { mock_model('Book', { id: 1, title: Faker::Lorem.word }) }
  let(:customer) { mock_model('Customer') }
  let(:review) { mock_model('Review', { title: nil, review_text: nil, rating: Random.rand(1..5), book: book, customer: customer }) }

  before(:each) do
    assign(:review, review)
    render
  end

  context 'new review form' do
    it 'renders form' do
      expect(rendered).to have_selector('form')
    end

    it 'renders title' do
      expect(rendered).to have_selector('#title')
    end

    it 'renders review' do
      expect(rendered).to have_selector('#review')
    end

    it 'renders rating' do
      expect(rendered).to have_selector('#rating-bar')
    end

  end
end
