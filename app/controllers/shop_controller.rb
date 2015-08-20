class ShopController < ApplicationController
  def index
    @page_num = params[:page] ? params[:page].to_i : 1

    @categories = Category.all
    @books = Book.page_books(@page_num)

    @paginate = Paginate.new
    @paginate.set_buttons(@page_num, Book.count)
  end

  def home
    book_id = params[:id] ? params[:id] : '1'

    if book_id == '1'
      @book = Book.first
      @prev_id = Book.last.id
    else
      @book = Book.find(book_id)
      @prev_id = Book.prev(book_id).id
    end
    @next_id = Book.next(book_id).id
  end

  def by_category
    @page_num = params[:page] ? params[:page].to_i : 1

    @category = Category.find(params[:ctg])
    @categories = Category.all
    @books = Book.page_books_by_ctg(@page_num, @category)

    @paginate = Paginate.new
    @paginate.set_buttons(@page_num, Book.where(category: @category).count)
  end

end
