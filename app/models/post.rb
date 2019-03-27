class Post < ApplicationRecord
  has_many :likes
  has_many :comments, dependent: :destroy

  scope :most_likes, ->{where(like_quantity: self.maximum(:like_quantity))}
end
