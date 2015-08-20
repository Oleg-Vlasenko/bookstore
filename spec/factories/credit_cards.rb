# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :credit_card do
    number Random.rand(1000..9999)
    CVV Random.rand(100...999)
    expiration_month Random.rand(1..12)
    expiration_year Date.today.next_year.year
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    customer nil
  end
end
