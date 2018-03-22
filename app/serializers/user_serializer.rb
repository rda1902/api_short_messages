class UserSerializer < ActiveModel::Serializer

  attributes :id, :email
  attribute :api_token, if: :api_token?

  def api_token?
    @instance_options[:api_token].present?
  end

end
