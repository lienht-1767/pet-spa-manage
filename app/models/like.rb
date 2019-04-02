class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  delegate :title, to: :post, prefix: true

  scope :total_like, ->{select(:id, :post_id).group(:post_id)}
end
