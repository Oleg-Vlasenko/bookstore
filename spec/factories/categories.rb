# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    # add n.to_s for unique titles, sometimes Faker repeat words
    sequence(:title) { |n| Faker::Lorem.word + n.to_s }
  end
end
