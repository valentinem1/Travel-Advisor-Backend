class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :comment, :rating, :user_id
end
