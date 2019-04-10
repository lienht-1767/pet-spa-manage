require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    session[:user_id] = @user.id
    @pet = FactoryBot.create(:pet)
    @service = FactoryBot.create(:service)
    @order = FactoryBot.create(:order)
  end
  let(:valid_attributes) {
    {
      date: 2.days.ago,
      user_id: @user,
      status: "Pending",
      order_details_attributes: [
        pet_id: @pet,
        service_id: @service,
        order_id: @order,
        price: 10
      ]
    }
  }

  describe "#new" do
    it "responds successfully" do
      get :new, params: {service_id: @service, service_price: @service.price}
      expect(response).to have_http_status(200)
    end
    it "assigns a new order" do
      get :new, params: {service_id: @service, service_price: @service.price}
      expect(assigns(:order)).to be_a_new(Order)
    end
  end

  context "#create" do
    before :each do
      post :create, params: {order: valid_attributes}
    end
    it "creates a order" do
      expect(Order.count).to eq(1)
    end
  end
end
