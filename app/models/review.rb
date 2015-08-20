class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :customer

  validates :rating, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  validates :title, :review_text, :book, :customer, presence: true

  # COLORS = [
  #     'red',
  #     'green',
  #     'blue'
  # ]
  #
  # redef before_validation
  #
  # def validate_color
  #   COLORS.detect self.color
  # end
end
