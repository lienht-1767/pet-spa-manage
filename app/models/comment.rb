class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  delegate :title, to: :post, prefix: true
  delegate :name, to: :user, prefix: true

  scope :count_cmt, ->(post_id){(where(post_id: post_id)).count}
end
