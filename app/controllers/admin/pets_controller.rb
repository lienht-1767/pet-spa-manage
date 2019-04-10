class Admin::PetsController < Admin::BaseController
  before_action :verify_admin!, only: %i(create index destroy)
  before_action :load_pet, :logged_in_user, only: %i(edit update destroy)

  def index
    @pets = Pet.search(params[:term]).page(params[:page]).per Settings.quantity_per_page
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new pet_params
    if @pet.save
      flash[:success] = t(".created")
      redirect_to admin_pets_path
    else
      flash[:error] = t(".create_unsuccess")
      render :new
    end
  end

  def edit; end

  def update
    if @pet.update pet_params
      flash[:success] = t(".pet_updated")
      redirect_to admin_pets_path
    else
      render :edit
    end
  end

  def destroy
    if @pet.destroy
      flash[:success] = t(".pet_deleted")
      redirect_to admin_pets_path
    else
      flash[:error] = t(".delete_failed")
      redirect_to admin_pets_path
    end
  end

  private

  def pet_params
    params.require(:pet).permit Pet::PET_PARAMS
  end

  def load_pet
    @pet = Pet.find_by id: params[:id]
    return if @pet
    flash[:error] = t(".pet_not_found")
    redirect_to admin_pets_path
  end
end
