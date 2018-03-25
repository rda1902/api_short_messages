class MessageSerializer < ActiveModel::Serializer

  belongs_to :user
  attributes :id, :text

end
