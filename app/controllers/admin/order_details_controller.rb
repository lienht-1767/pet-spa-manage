class Admin::OrderDetailsController < Admin::BaseController
	def show
		 @detail = OrderDetail.find_by id: params[:id]
	end
end
