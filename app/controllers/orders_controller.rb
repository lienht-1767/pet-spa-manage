class OrdersController < ApplicationController
  before_action :load_pets_services, only: %i(new create)
  before_action :load_order, only: %i(show)

  def new
    @order = Order.new
    @order.order_details.build
    @service_id = params[:order][:service_id]
	end

	def index; end
  
  def show; end

  def create
    @order = Order.new order_params
    if @order.save
    	flash[:success] = "Ordered"
    	redirect_to order_detail_path(@order.id)
    else
    	flash[:error] = "fail"
    	render :new
    end
	end

  private
  def order_params
    params.require(:order).permit Order::ORDER_PARAMS
  end

  def load_pets_services
    @pets = Pet.all_pets
    @services = Service.public_service
  end

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:error] = t ".not_found"
    redirect_to root_path
  end
end
