class Post < ApplicationRecord
  has_many :likes
  has_many :comments, dependent: :destroy

  scope :most_likes, ->{where like_quantity: self.maximum(:like_quantity)}
  scope :other_posts, ->(id){where.not id: id}
  scope :all_posts, ->{select :id, :title, :sumary, :content}
end
