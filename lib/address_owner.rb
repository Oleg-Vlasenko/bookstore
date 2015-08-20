module AddressOwner

  # def get_name
  #   if self.class.name == 'Customer'
  #     return {
  #       first_name: self.first_name, 
  #       last_name: self.last_name
  #     }
  #   elsif (self.class.name == 'Order') && (self.customer)
  #     return {
  #       first_name: self.customer.first_name, 
  #       last_name: self.customer.last_name
  #     }
  #   end      
  #   {
  #     first_name: '', 
  #     last_name: ''
  #   }
  # end
  
  # def init_addresses
  #   name = get_name
  #   self.build_billing_address(name) unless self.billing_address
  #   self.build_shipping_address(name) unless self.shipping_address
  # end
  
  def test_hash
    if (self.class.name == 'Order') && (self.customer)
      attr = self.customer.billing_address.attributes
      clear_attr(attr)
    end  
  end
  
  private

  def clear_attr(attr)
    extra_keys = [:id, :created_at, :updated_at]
    attr.delete_if { |k, v| extra_keys.index(k.to_sym) }
  end
  
end 
