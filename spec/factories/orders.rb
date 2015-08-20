# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    completed_date Date.new(2014, 01, 01)
    state 'in_progress'
    customer nil
    credit_card nil
  end
end
