class User < ApplicationRecord

  include UserQueries

  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :votes, dependent: :destroy
  has_many :messages, dependent: :destroy

  def generate_api_token
    update_attribute(:api_token, Digest::SHA1.hexdigest([Time.now.getutc, rand].join))
  end

end
