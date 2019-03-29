class ServicesController < ApplicationController
  before_action :load_service, only: %i(show)

  def index
    @services = Service.page(params[:page]).per Settings.quantity_per_page
  end

  def show
    @other_services = Service.other_services(@service).limit Settings.limit_home
  end

  private
  def load_service
    @service = Service.find_by id: params[:id]
    return if @service
    flash[:error] = t(".service_not_found")
    redirect_to root_path
  end
end
