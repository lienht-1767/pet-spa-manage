class OrdersController < ApplicationController
	def new
		@order = Order.new
		@order.order_details.build
		@pets = Pet.all_pets
		@services = Service.public_service
	end

	def index
	end

	def create
    @order = Order.new order_params
    if @order.save
    	flash[:success] = "Ordered"
    	redirect_to orders_path
    else
    	flash[:error] = "fail"
    	render :new
    end
	end

	private
	def order_params
		params.require(:order).permit :user_id, :date , order_details_attributes:
      [:pet_id, :service_id, :order_id, :price]
	end
end
