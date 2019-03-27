class StaticPagesController < ApplicationController
  def home
    @post = Post.most_likes
    @services = Service.all
  end

  def service_detail
    @service = Service.find_by id: params[:id]
  end

  def order
    @user_id = params[:user_id]
    @petname = params[:petname]
    @breed = params[:breed]
    @gender = params[:gender]
    @height = params[:height]
    @weight = params[:weight]
    @date = params[:publishing_date]
    @service = params[:services]

    Order.transaction do
      Order.new order_params
      Pet.new pet_params
      OrderDetail.new detail_order_params
    end
  end

  private
  def order_params
    params.require(:order).permit :date, :user_id
  end

  def detail_order_params
    params.require(:order_detail).permit :price, :order_id, :pet_id, :service_id
  end

  def pet_params
    params.require(:pet).permit :name, :breed, :gender, :height, :weight
  end
end
