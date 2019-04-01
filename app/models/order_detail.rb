class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :pet
  belongs_to :service

  after_create :update_price

  private
  def update_price
    service = Service.find_by id: self.service_id
    return unless service
    self.update price: service.price
  end
end
