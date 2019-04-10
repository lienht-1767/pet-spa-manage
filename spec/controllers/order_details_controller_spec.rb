require "rails_helper"

RSpec.describe OrderDetailsController, type: :controller do
  let!(:order) {FactoryBot.create :order}
  let!(:service) {FactoryBot.create :service}
  let!(:pet) {FactoryBot.create :pet}
  let!(:order_detail) {FactoryBot.create :order_detail}

  context "#show" do
    it "responds successfully" do
      get :show, params: { id: order_detail.id }
      expect(response).to have_http_status(200)
    end
  end
end
