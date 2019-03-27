class OrdersController < ApplicationController
  def create
    @order = Order.new order_params
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
