class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :pet
  belongs_to :service

  delegate :date, to: :order, prefix: true
  delegate :name, to: :pet, prefix: true
  delegate :name, to: :service, prefix: true
  delegate :price, to: :service, prefix: true

  scope :detail, ->(order_id){where order_id: order_id}
end
