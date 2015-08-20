class Delivery
  attr_reader :name
  attr_reader :price
  
  def initialize(name, price)
    @name = name
    @price = price
  end
  
  def descript
    "#{@name} + $#{'%.2f' % @price}"
  end
end