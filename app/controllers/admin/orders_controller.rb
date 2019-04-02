class Admin::OrdersController < Admin::BaseController
	def index
		@orders = Order.by_lastest.page(params[:page]).per Settings.per_page
	end
end
