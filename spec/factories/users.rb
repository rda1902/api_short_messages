FactoryBot.define do
  factory :user, class: User do
    email Faker::Internet.email
    password Faker::Lorem.characters(10)
  end
end
