class Pet < ApplicationRecord
  has_many :order_details

  scope :all_pets, ->{select :id, :name}
end
