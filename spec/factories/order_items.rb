FactoryGirl.define do
  factory :order_item do
    price 1.5
    quantity 2
    total_sum 3
    book nil
    order nil
  end

end
