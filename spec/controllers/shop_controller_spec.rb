require 'rails_helper'

RSpec.describe ShopController, :type => :controller do

  describe 'GET home' do
    let(:book) { mock_model('Book', id: '3') }
    let(:prev_book) { mock_model('Book', id: '2') }
    let(:next_book) { mock_model('Book', id: '4') }

    before(:each) do
      allow(Book).to receive(:find).with(book.id).and_return(book)
      allow(Book).to receive(:prev).with(book.id).and_return(prev_book)
      allow(Book).to receive(:next).with(book.id).and_return(next_book)

      get :home, id: '3'
    end

    it 'assign current book' do
      expect(assigns[:book]).to eq(book)
    end

    it 'assign previous book id' do
      expect(assigns[:prev_id]).to eq(prev_book.id)
    end

    it 'assign next book id' do
      expect(assigns[:next_id]).to eq(next_book.id)
    end

    it 'renders home template' do
      expect(response).to render_template('home')
    end
  end

  describe 'GET index' do
    let(:page_num) { 3 }
    let(:paginate) { Paginate.new }

    before(:each) do
      allow(Book).to receive(:page_books).with(page_num).and_return([])
      allow(Category).to receive(:all).and_return([])
      get :index, page: page_num
    end

    it 'assign current page' do
      expect(assigns[:page_num]).to eq(page_num)
    end

    it 'assign categories' do
      expect(assigns[:categories]).to eq(Category.all)
    end

    it 'assign page books' do
      expect(assigns[:books]).to eq(Book.page_books(page_num))
    end

    it 'assign paginate' do
      expect(assigns(:paginate).class).to eq(paginate.class)
    end

    it 'initialize paginate buttons' do
      paginate.set_buttons(page_num, 100)
      expect(assigns(:paginate).first_btn.class).to eq(paginate.first_btn.class)
    end

    it 'renders index template' do
      expect(response).to render_template('index')
    end
  end

  describe 'Show shop, GET by_category' do
    let(:category) { mock_model('Category') }
    let(:page_num) { 3 }
    let(:paginate) { Paginate.new }

    before(:each) do
      allow(Category).to receive(:find).with(category.id.to_s).and_return(category)
      allow(Category).to receive(:all).and_return([])
      allow(Book).to receive(:page_books_by_ctg).with(page_num, category).and_return([])
      # Category.stub(:find).with(category.id.to_s).and_return(category)
      # Category.stub(:all).and_return([])
      # Book.stub(:page_books_by_ctg).with(page_num, category).and_return([])

      get :by_category, page: page_num, ctg: category.id
    end

    it 'assign selected category' do
      expect(assigns[:category]).to eq(category)
    end

    it 'assign categories' do
      expect(assigns[:categories]).to eq(Category.all)
    end

    it 'assign current page' do
      expect(assigns[:page_num]).to eq(page_num)
    end

    it 'assign page books by category' do
      expect(assigns[:books]).to eq(Book.page_books_by_ctg(page_num, category))
    end

    it 'assign paginate' do
      expect(assigns(:paginate).class).to eq(paginate.class)
    end

    it 'initialize paginate buttons' do
      paginate.set_buttons(page_num, 100)
      expect(assigns(:paginate).first_btn.class).to eq(paginate.first_btn.class)
    end

    it 'renders shop by category template' do
      expect(response).to render_template('by_category')
    end
  end

end
