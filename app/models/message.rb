class Message < ApplicationRecord

  belongs_to :user
  has_many :votes
  validates :text, length: { minimum: 1, maximum: 140, message: :message_is_long }

end
