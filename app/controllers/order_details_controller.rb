class OrderDetailsController < ApplicationController
	def show
		@order_detail = OrderDetail.find_by id: params[:id]
	end
end
