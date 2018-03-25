require 'rails_helper'

RSpec.describe Api::V1::Users::RegistrationsController, type: :controller do
  context 'POST create' do
    let(:user) { build :user }
    it 'creates user' do
      params = { params: { users: { email: user.email, password: user.password } } }
      post :create, params
      expect(response.status).to eq 200
      expect(User.all.size).to eq 1
      hash = JSON.parse(response.body)
      user_db = User.first
      expect(hash['api_token']).to eq user_db.api_token
      expect(hash['email']).to eq user.email
    end

    it 'try create user but email exist' do
      user = create :user
      params = { params: { users: { email: user.email, password: user.password } } }
      post :create, params
      expect(response.status).to eq 403
    end

    it 'try create user but email incorrect' do
      params = { params: { users: { email: '111', password: 123456789 } } }
      post :create, params
      expect(response.status).to eq 400
    end
  end
end
