class OrdersController < ApplicationController
  def create
    @order = Order.new order_params
  end

  def user_params
    params.require(:order).permit :user_id, :date, order_details_attributes:
      [:order_id]
  end
end
