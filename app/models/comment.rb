class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  COMMENT_PARAMS = [:user_id, :content, :post_id].freeze

  delegate :title, to: :post, prefix: true
  delegate :name, to: :user, prefix: true

  scope :count_cmt, ->(post_id){(where(post_id: post_id)).count}
  scope :by_lastest, ->{order created_at: :desc}
  scope :lastest_by_post, ->(post_id){(where(post_id: post_id)).order created_at: :desc}
end
