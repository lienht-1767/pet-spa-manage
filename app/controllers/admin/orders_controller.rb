class Admin::OrdersController < Admin::BaseController
  before_action :load_order, only: %i(edit update destroy)
  before_action :load_detail_order, only: %(show)

  def index
    @orders = Order.by_lastest.page(params[:page]).per Settings.per_page
  end

  def show; end

  def edit; end

  def update
    if @order.update order_params
      flash[:success] = t ".success"
      redirect_to admin_orders_path
    else
      render :edit
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t ".deleted"
      redirect_to request.referer
    else
      flash[:error] = t ".delete_fail"
      redirect_to admin_orders_path
    end
  end

  private
  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:error] = t ".not_found_order"
    redirect_to admin_orders_path
  end

  def order_params
    params.require(:order).permit Order::ORDER_PARAMS
  end

  def load_detail_order
    @detail = OrderDetail.find_by id: params[:id]
    return if @detail
    flash[:error] = t ".not_found_detail"
    redirect_to admin_orders_path
  end
end
