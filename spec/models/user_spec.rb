require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }
  it 'checks generate_api_token' do
    expect(user.api_token).to equal(nil)
    user.generate_api_token
    expect(user.api_token).not_to equal(nil)
  end
end
