FactoryGirl.define do
  factory :review do
    sequence(:title) {Faker::Lorem.sentence(2)}
    review_text Faker::Lorem.sentence(4)
    rating {Random.rand(1..5)}
    association :book, factory: :book
    association :customer, factory: :customer
  end
end
