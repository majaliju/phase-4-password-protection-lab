class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password_digest, :password, :password_confirmation
end
