class OrderDetailsController < ApplicationController
  before_action :load_order, only: %i(show)

  def show; end

  private
  def load_order
    @order_detail = OrderDetail.find_by id: params[:id]
    return if @order_detail
    flash[:error] = t ".order_not_found"
    redirect_to new_order_path
  end
end
