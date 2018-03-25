require 'rails_helper'

RSpec.describe Api::V1::VotesController, type: :controller do
  let!(:user) { create :user, api_token: 'rrererererre' }
  let!(:message) { create :message, user: user }
  context 'AUTH' do
    before do
      @request.headers['Authorization'] = "Token #{user.api_token}"
      @request.headers['HTTP_ACCEPT'] = 'application/json'
    end
    context 'GET update' do
      it 'like' do
        params = { params: { message_id: message.id } }
        get :update, params
        expect(Vote.all.size).to eq 1
        expect(response.status).to eq 200
      end

      it 'unlike' do
        create :vote, user: user, message: message
        expect(Vote.all.size).to eq 1
        params = { params: { message_id: message.id } }
        get :update, params
        expect(Vote.all.size).to eq 0
        expect(response.status).to eq 200
      end
    end
  end

  context 'NOT AUTH' do
    context 'GET update' do
      it 'try to vote and receive error' do
        params = { params: { message_id: message.id } }
        get :update, params
        expect(Vote.all.size).to eq 0
        expect(response.status).to eq 401
      end
    end
  end
end
