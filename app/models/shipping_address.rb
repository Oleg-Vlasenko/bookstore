class ShippingAddress < Address
  has_one :customer
  has_one :order
end