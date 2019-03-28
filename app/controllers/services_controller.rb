class ServicesController < ApplicationController
  def index
    @services = Service.page(params[:page]).per Settings.quantity_per_page
  end

  def show
    @service = Service.find_by id: params[:id]
    @other_services = Service.where.not(id: @service.id)
  end
end
