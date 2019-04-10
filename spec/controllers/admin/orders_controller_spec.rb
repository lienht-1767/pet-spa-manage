require "rails_helper"

RSpec.describe Admin::OrdersController, type: :controller do
  before :each do
    user = FactoryBot.create(:user)
    session[:user_id] = user.id
  end

  let(:valid_order) {
    {
      user_id: 1,
      date: 2.days.ago
    }
  }
  let(:invalid_order) {
    {
      user_id: "",
      date: ""
    }
  }

  context "#index" do
    it "responds successfully" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  let!(:order) {FactoryBot.create :order}
  context "#show" do
    it "responds successfully" do
      get :show, params: { id: order.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "#update" do
    context "update successfully" do
      it "update successfully" do
        expect {
          put :update, params: {id: order.id, order: valid_order}
        }.to change(Order, :count).by(1)
        expect(response).to have_http_status(200)
        expect(flash[:success]).to be_present
      end
    end
    context "update fail" do
      it "update fail" do
        expect {
          put :update, params: {id: order.id, order: invalid_order}
        }.to change(Order, :count).by(0)
        expect(response).to have_http_status(200)
        expect(flash[:success]).not_to be_present
      end
    end
  end

  context "#destroy" do
    let(:order) { FactoryBot.create :order }
    it "delete successfully" do
      expect {
        delete :destroy, params: { id: order.id }
      }.to change(Order, :count).by(-1)
      expect(response).to have_http_status(200)
    end
    it  "delete fail" do
      expect {delete :destroy, params: { id: "" }}
      expect(flash[:success]).not_to be_present
      expect(response).to have_http_status(200)
    end
  end
end
