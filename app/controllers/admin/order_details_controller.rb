class Admin::OrderDetailsController < Admin::BaseController
  before_action :load_order, only: %i(show)

  def show; end

  private
  def load_order
    @detail = OrderDetail.find_by id: params[:id]
    return if @detail
    flash[:error] = t ".not_found"
    redirect_to admin_orders_path
  end
end
