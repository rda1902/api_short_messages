require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :controller do
  context 'AUTH' do
    let!(:user) { create :user, api_token: 'rrererererre' }
    before do
      @request.headers['Authorization'] = "Token #{user.api_token}"
      @request.headers['HTTP_ACCEPT'] = 'application/json'
    end
    context 'POST create' do
      it 'creates message' do
        message = build :message
        params = { params: { messages: { text: message.text } } }
        post :create, params
        expect(Message.all.size).to eq 1
        hash = JSON.parse(response.body)
        expect(hash['text']).to eq message.text
        user_hash = JSON.parse(ActiveModelSerializers::SerializableResource.new(user).to_json)
        expect(hash['user']).to eq user_hash
        expect(response.status).to eq 200
      end

      it 'try create message and receive error' do
        params = { params: { messages: { text: '' } } }
        post :create, params
        expect(Message.all.size).to eq 0
        hash = JSON.parse(response.body)
        expect(hash['errors']['text'].first).to eq I18n.t('activerecord.errors.messages.message_error')
        expect(response.status).to eq 400
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

    context 'GET index' do
      let(:user) { create :user }
      let!(:message) { create :message, user: user }
      it 'receive all messages' do
        get 'index'
        hash = JSON.parse(response.body)
        expect(hash.size).to eq Message.all.size
      end
    end
  end
end
