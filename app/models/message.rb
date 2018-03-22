class Message < ApplicationRecord

  belongs_to :user, optional: true
  validates :text, length: { minimum: 1, maximum: 140, message: :message_is_long }

end
