# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :author do
    sequence(:first_name) { Faker::Name.first_name}
    sequence(:last_name) {Faker::Name.last_name}
    biography Faker::Lorem.sentence(10)
  end
end
