class Service < ApplicationRecord
  has_many :order_details

  scope :all_services, ->{select :id, :name, :description, :price}
  scope :other_services, ->(id){where.not id: id}
end
