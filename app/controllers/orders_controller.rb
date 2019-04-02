class OrdersController < ApplicationController
  before_action :load_order, only: %i(show)
  before_action :logged_in_user

  def new
    @order = Order.new
    @order.order_details.build
    @service_id = params[:order][:service_id]
    @service_price = params[:order][:price]
  end

  def index; end

  def show; end

  def create
    @order = Order.new order_params
    if @order.save
      flash[:success] = t ".ordered"
      redirect_to order_detail_path @order
    else
      flash[:error] = t ".fail"
      render :new
    end
  end

  private
  def order_params
    params.require(:order).permit Order::ORDER_PARAMS
  end

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:error] = t ".not_found"
    redirect_to root_path
  end
end
