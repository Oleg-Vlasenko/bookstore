class Order < ActiveRecord::Base
  include AddressOwner

  @@states = ['in_progress', 'completed', 'shipped']
  @@default_state = @@states.first
  cattr_reader :states
  cattr_reader :ship_variants

  belongs_to :customer
  belongs_to :credit_card
  has_many :items, class_name: 'OrderItem'

  belongs_to :billing_address
  accepts_nested_attributes_for :billing_address, allow_destroy: true
  
  belongs_to :shipping_address
  accepts_nested_attributes_for :shipping_address, allow_destroy: true

  before_validation :set_default_state

  validates :completed_date, presence: true, if: :completed?
  validates :state, presence: true, inclusion: { in: @@states }
  validates :shipping, numericality: { only_integer: true },  allow_nil: true

  def Order.init_delivery
    @@ship_variants = [
      Delivery.new('UPS Ground', 5),
      Delivery.new('UPS Two Day', 10),
      Delivery.new('UPS One Day', 15)
    ]
  end
  
  init_delivery

  def subtotal_price
    self.items.sum(:total_sum).round(2)
  end

  def total_price
    (self.subtotal_price.to_f + self.shipping.to_i).round(2)
  end

  def add_book(book_id, quantity)
    return nil if self.new_record?

    book = Book.find_by_id(book_id)
    new_item = self.items.new(book: book, price: book.price, quantity: quantity)
    new_item.save
    return new_item
  end
  
  def set_completed
    self.state = @@states[1]
  end
  
  def set_shipped
    self.state = @@states[2]
  end
  
  def init_addresses
    if self.customer
      customer = self.customer
      customer_name = {
        first_name: customer.first_name, 
        last_name: customer.last_name
      }

      unless self.billing_address 
        if customer.billing_address
          addr_data = clear_attr(self.customer.billing_address.attributes)
          self.build_billing_address(addr_data)
        else
          self.build_billing_address(customer_name)
        end
      end
      unless self.shipping_address 
        if customer.shipping_address
          addr_data = clear_attr(self.customer.shipping_address.attributes)
          self.build_shipping_address(addr_data)
        else
          self.build_shipping_address(customer_name)
        end
      end
    end
  end
  
  def save_adresses(addr_data)
    self.billing_address_attributes = addr_data[:billing_address]
    self.one_address = addr_data[:order][:one_address]
    if self.one_address
      self.shipping_address_attributes = clear_attr(addr_data[:billing_address])
    else
      self.shipping_address_attributes = addr_data[:shipping_address]
    end
    
    self.valid?
  end
  
  def init_shipping
    if self.shipping.to_f == 0
      self.shipping = @@ship_variants[0].price
    end
  end
  
  def get_shipping
    @@ship_variants.each do |v|
      return v if v.price == self.shipping
    end
    @@ship_variants[0]
  end

  private

  def set_default_state
    self.state = @@default_state unless self.state
  end

  def completed?
    self.state == @@states[1] or self.state == @@states[2]
  end
  
  def clear_attr(attr)
    extra_keys = [:id, :created_at, :updated_at]
    attr.delete_if { |k, v| extra_keys.index(k.to_sym) }
  end

end
