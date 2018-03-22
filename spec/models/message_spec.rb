require 'rails_helper'

RSpec.describe Message, type: :model do
  message_is_long = I18n.t('activerecord.errors.messages.message_is_long')
  it { should validate_length_of(:text).is_at_least(1).with_message(message_is_long) }
  it { should validate_length_of(:text).is_at_most(140).with_message(message_is_long) }
end
