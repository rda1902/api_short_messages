require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }
  it 'checks generate_api_token' do
    expect(user.api_token).to equal(nil)
    user.generate_api_token
    expect(user.api_token).not_to equal(nil)
  end
  context 'tops methods' do
    let!(:user1) { create :user, email: Faker::Internet.email }
    let!(:user2) { create :user, email: Faker::Internet.email }
    let!(:user3) { create :user, email: Faker::Internet.email }
    let!(:message1) { create :message, user: user1 }
    let!(:message2) { create :message, user: user1 }
    let!(:message3) { create :message, user: user2 }
    let!(:vote1) { create :vote, message: message1, user: user2 }
    let!(:vote2) { create :vote, message: message2, user: user2 }
    let!(:vote3) { create :vote, message: message2, user: user3 }
    let!(:vote4) { create :vote, message: message3, user: user1 }

    it 'test top_by_average_message_rating' do
      response = User.top_by_average_message_rating
      expect(response[0][:average_messages_rating]).to eq 1.5
      expect(response[1][:average_messages_rating]).to eq 1
    end

    it 'test top_by_count_of_messages' do
      response = User.top_by_count_of_messages
      expect(response[0].id).to eq user1.id
      expect(response[0].messages_count).to eq user1.messages.size
    end

    it 'test top_by_vote_of_messages' do
      response = User.top_by_vote_of_messages
      expect(response[0][:message_votes_count]).to eq 2
      expect(response[0][:message]).to eq message2
      expect(response[1][:message_votes_count]).to eq 1
      expect(response[1][:message]).to eq message3
    end
  end
end
