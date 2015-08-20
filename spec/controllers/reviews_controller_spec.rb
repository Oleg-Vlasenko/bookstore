require 'rails_helper'

RSpec.describe ReviewsController, :type => :controller do

  let(:review) { mock_model('Review') }
  let(:current_customer) { mock_model('Customer') }
  
  before(:each) do
    allow(Review).to receive(:new).and_return(review)
    allow(Customer).to receive(:find_by_id).and_return(current_customer)
  end

  describe "GET new" do
    before(:each) do
      get :new, book_id: 1
    end

    it 'assigns @review' do
      expect(assigns(:review)).to eq(review)
    end
  end

  describe "POST create" do
    before(:each) do
      allow(review).to receive(:save).and_return(true)
      post :create, { book_id: 1, review: { book_id: 1, id: 1, rating: '5' } }
    end

    it 'creates review' do
      expect(assigns(:review)).to eq(review)
    end

    it 'redirects to book' do
      expect(response).to redirect_to('/books/1')
    end
    
  end

end
