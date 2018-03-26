require 'rails_helper'

RSpec.describe Message, type: :model do
  message_error = I18n.t('activerecord.errors.messages.message_error')
  it { should validate_length_of(:text).is_at_least(1).with_message(message_error) }
  it { should validate_length_of(:text).is_at_most(140).with_message(message_error) }
end
