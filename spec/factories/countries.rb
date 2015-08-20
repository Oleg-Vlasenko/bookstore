# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
    sequence(:name) { Faker::Address.country }
  end
end
