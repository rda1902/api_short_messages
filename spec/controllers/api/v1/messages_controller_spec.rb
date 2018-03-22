require 'rails_helper'

RSpec.describe Api::V1::Users::MessagesController, type: :controller do
  context 'AUTH' do
    before do
      @request.headers['Authorization'] = "Token #{user.api_token}"
      @request.headers['HTTP_ACCEPT'] = 'application/json'
    end
    context 'POST create' do
      let!(:user) { create :user, api_token: 'rrererererre' }
      it 'creates message' do
        message = build :message
        params = { params: { messages: { text: message.text } } }
        post :create, params
        expect(Message.all.size).to eq 1
        hash = JSON.parse(response.body)
        expect(hash['text']).to eq message.text
        expect(response.status).to eq 200
      end
    end
  end

  context 'NOT AUTH' do
    context 'POST create' do
      it 'try create message and receive error' do
        message = build :message
        params = { params: { messages: { text: message.text } } }
        post :create, params
        expect(Message.all.size).to eq 0
        expect(response.status).to eq 401
      end
    end
  end
end
