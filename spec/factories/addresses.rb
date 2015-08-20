# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    sequence(:first_name) { Faker::Name.first_name}
    sequence(:last_name) {Faker::Name.last_name}
    address Faker::Address.street_address
    zip_code Faker::Address.zip_code
    city Faker::Address.city
    phone Faker::PhoneNumber.phone_number
    country nil
  end
  factory :billing_address do
    sequence(:first_name) { Faker::Name.first_name}
    sequence(:last_name) {Faker::Name.last_name}
    address Faker::Address.street_address
    zip_code Faker::Address.zip_code
    city Faker::Address.city
    phone Faker::PhoneNumber.phone_number
    country nil
  end
  factory :shipping_address do
    sequence(:first_name) { Faker::Name.first_name}
    sequence(:last_name) {Faker::Name.last_name}
    address Faker::Address.street_address
    zip_code Faker::Address.zip_code
    city Faker::Address.city
    phone Faker::PhoneNumber.phone_number
    country nil
  end
end
