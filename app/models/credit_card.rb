class CreditCard < ActiveRecord::Base
  belongs_to :customer
  has_many :orders

  validates :number, :CVV, :first_name, :last_name, presence: true
  validate :expiration_year_month_range

  def expiration_year_month_range
    if !Date.valid_date?(self.expiration_year.to_i, self.expiration_month.to_i, 1)
      errors.add(:expiration_year, 'incorrect expiration date')
      errors.add(:expiration_month, 'incorrect expiration date')
    elsif Date.new(self.expiration_year, self.expiration_month).next_month <= Date.today
      errors.add(:expiration_year, 'expiration date should be greater than current')
      errors.add(:expiration_month, 'expiration date should be greater than current')
    end
  end
  
  def save_links(customer, order)
    unless customer.credit_card
      customer.credit_card = self
      customer.save
    end
    unless order.credit_card
      order.credit_card = self
      order.save
    end
  end
end
