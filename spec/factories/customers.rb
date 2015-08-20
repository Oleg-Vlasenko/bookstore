# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    sequence(:first_name) { Faker::Name.first_name}
    sequence(:last_name) {Faker::Name.last_name}
    email Faker::Internet.email
    sequence(:password) { Faker::Lorem.characters(10) }
  end
end
