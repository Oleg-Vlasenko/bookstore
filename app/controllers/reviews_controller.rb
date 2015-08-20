class ReviewsController < ApplicationController
  before_action :only_auth_resource

  def new
    @review = Review.new({ book: Book.find_by_id(params[:book_id]), customer: @current_customer, rating: '1' })
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to book_path(review_params[:book_id])
    else
      render :new
    end
  end

  private
    
  def review_params
    params.require(:review).permit(:title, :review_text, :rating, :book_id, :customer_id)
  end
end
