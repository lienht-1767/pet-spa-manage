class Admin::ServicesController < Admin::BaseController
  before_action :load_service, only: %i(edit update destroy)

  def index
    @services = Service.by_lastest.page(params[:page]).per Settings.per_page
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new service_params

    if @service.save
      flash[:success] = t(".created")
      redirect_to admin_services_path
    else
      flash[:error] = t(".create_unsuccess")
      render :new
    end
  end

  def edit; end

  def update
    if @service.update service_params
      flash[:success] = t ".success"
      redirect_to admin_services_path
    else
      render :edit
    end
  end

  def destroy
    if @service.destroy
      flash[:success] = t ".success"
    else
      flash[:error] = t ".fail"
    end
    redirect_to admin_services_path
  end

  private
  def load_service
    @service = Service.find_by id: params[:id]
    return if @service
    flash[:error] = t ".not_found_service"
    redirect_to admin_services_path
  end

  def service_params
    params.require(:service).permit Service::SERVICE_PARAMS
  end
end
