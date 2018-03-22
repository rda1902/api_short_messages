FactoryBot.define do
  factory :message, class: Message do
    text Faker::Lorem.characters(50)
  end
end
