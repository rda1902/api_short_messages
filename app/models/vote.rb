class Vote < ApplicationRecord

  belongs_to :user
  belongs_to :message

  def self.touch_vote(message, current_user)
    vote = find_or_initialize_by(message: message, user: current_user)
    vote.persisted? ? vote.destroy : vote.save
  end

end
