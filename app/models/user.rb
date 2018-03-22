class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :trackable, :validatable

  def generate_api_token
    update_attribute(:api_token, Digest::SHA1.hexdigest([Time.now.getutc, rand].join))
  end

end
