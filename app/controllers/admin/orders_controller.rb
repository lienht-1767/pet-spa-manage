class Admin::OrdersController < Admin::BaseController
  before_action :load_order, only: %i(show edit update destroy)

  def index
    @orders = Order.by_lastest.page(params[:page]).per Settings.per_page
  end

  def show
    @details = OrderDetail.detail(@order)
  end

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
      redirect_to admin_orders_path
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
end
