ActiveRecord::Base.transaction do
  10.times.each do |i|
    user = User.create(email: "test#{i}@test.ru", password: Faker::Lorem.characters(10))
    (1..100).to_a.sample.times.each { Message.create!(user: user, text: Faker::Lorem.characters(40)) }
  end

  600.times.each do
    message = Message.find(Message.pluck(:id).sample)
    user = User.find(User.pluck(:id).reject { |v| v == message.user_id }.sample)
    Vote.touch_vote(message, user)
  end
end
