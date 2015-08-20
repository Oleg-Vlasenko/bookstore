require 'rails_helper'

RSpec.describe BooksController, :type => :controller do
  let(:book) { mock_model('Book', id: '3') }
  let(:wrong_book_id) { '9998' }

  before(:each) do
    allow(Book).to receive(:find_by_id).with(book.id).and_return(book)
    allow(Book).to receive(:find_by_id).with(wrong_book_id).and_return(nil)
  end

  describe 'GET show' do
    it 'assigns @book' do
      get :show, id: book.id
      expect(assigns[:book]).to eq(book)
    end
      
    it 'renders show template' do
      get :show, id: book.id
      expect(response).to render_template('show')
    end
      
    it 'redirects to 404 page if book id is wrong' do
      get :show, id: wrong_book_id
      expect(response).to redirect_to('/404')
    end
  end
end

