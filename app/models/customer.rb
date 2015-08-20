class Customer < ActiveRecord::Base
  include AddressOwner

  @@cart_states = ['in_progress', 'address', 'delivery', 'payment', 'confirm']
  @@default_cart_state = @@cart_states.first
  
  cattr_reader :cart_states
  cattr_reader :default_cart_state

  has_many :orders
  has_many :reviews
  has_one :credit_card
  belongs_to :billing_address
  accepts_nested_attributes_for :billing_address, allow_destroy: true
  
  belongs_to :shipping_address
  accepts_nested_attributes_for :shipping_address, allow_destroy: true

  has_secure_password
  
  before_validation :set_default_cart_state

  validates :email, format: { with: /\A.+@.+\..+\z/ , message: 'Not valid email!' }, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :cart_state, inclusion: { in: @@cart_states }
  
  def name
    first_name + ' ' + last_name
  end
  
  def get_current_order_info
    order = get_current_order
    if order
      if order.items.length > 0
        return "(#{order.items.length}) $#{'%.2f' % order.total_price}"
      else
        return '(EMPTY)'
      end
    else
      return '(EMPTY)'
    end
  end
  
  def get_current_order
    order = Order.where(customer: self, state: :in_progress).first
    if order && order.items.empty?
      order.destroy
      order = nil
    end
    
    return order
  end

  def get_current_order!
    order = Order.where(customer: self, state: :in_progress).first
    if !order
      order = Order.new(customer: self)
      order.save
    end
    return order
  end
  
  def get_orders(state)
    Order.where(customer: self, state: state)
  end
  
  def change_password(password)
    result = true
    unless password[:current].blank? || password[:new].blank?
      if self.authenticate(password[:current])
        self.password = password[:new]
      else
        result = false
      end
    end
    result
  end

  def init_addresses
    name = {
      first_name: self.first_name, 
      last_name: self.last_name
    }

    self.build_billing_address(name) unless self.billing_address
    self.build_shipping_address(name) unless self.shipping_address
  end

  def update_settings(upd_data)
    self.billing_address_attributes = upd_data[:billing_address]
    self.shipping_address_attributes = upd_data[:shipping_address]

    unless change_password(upd_data[:password])
      self.errors.add(:authenticate, 'incorrect password')
    end
    
    update(upd_data[:customer])
    
    self.valid? && !self.errors.any?
  end

  def set_default_cart_state
    self.cart_state = @@default_cart_state unless self.cart_state
  end
  
  def get_credit_card!
    self.credit_card || CreditCard.new(first_name: self.first_name, last_name: self.last_name)
  end
  
end