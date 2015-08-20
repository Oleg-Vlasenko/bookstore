class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :reviews

  validates :title, :price, :stock, presence: true
  validates :price, :stock, numericality: { greater_than: 0 }

  def Book.page_books(page_num)
    self.offset((page_num - 1) * Paginate.books_on_page).limit(Paginate.books_on_page)
  end

  def Book.page_books_by_ctg(page_num, category_id)
    self.where(category: category_id).offset((page_num - 1) * Paginate.books_on_page).limit(Paginate.books_on_page)
  end

  def Book.prev(book_id)
    Book.where('id < ?', book_id).last
  end

  def Book.next(book_id)
    Book.where('id > ?', book_id).first
  end
end
