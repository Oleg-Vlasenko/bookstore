class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  before_save :set_total_sum

  validates :quantity, :price, presence: true, numericality: { greater_than: 0 }

  private

  def set_total_sum
    self.total_sum = (self.price * self.quantity).round(2)
  end
end
