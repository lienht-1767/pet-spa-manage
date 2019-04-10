require "rails_helper"

RSpec.describe Admin::PetsController, type: :controller do
  before :each do
    user = FactoryBot.create(:user)
    session[:user_id] = user.id
  end

  let(:valid_pet) {
    {
      name: FFaker::Lorem.phrase,
      description: FFaker::Lorem.phrase
    }
  }
  let(:invalid_pet) {
    {
      name: "",
      description: ""
    }
  }

  context "#index" do
    it "responds successfully" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "#new" do
    it "responds successfully" do
      get :new
      expect(response).to have_http_status(200)
    end
    it "assigns a new pet" do
      get :new
      expect(assigns(:pet)).to be_a_new(Pet)
    end
  end

  describe "#create" do
    context "create successfully" do
      it "creates pet" do
        expect {
          post :create, params: { pet: valid_pet}
        }.to change(Pet, :count).by(1)
        expect(flash[:success]).to be_present
      end
    end

    context "create fail" do
      it "creates pet" do
        expect {
          post :create, params: { pet: invalid_pet}
        }.to change(Pet, :count).by(0)
        expect(flash[:error]).to be_present
      end
    end
  end

  let!(:pet) { FactoryBot.create :pet }
  describe "#update" do
    context "update successfully" do
      it "update successfully" do
        put :update, params: {id: pet.id, pet: valid_pet}
        expect(Pet.count).to eq(1)
        expect(response).to have_http_status(200)
        expect(flash[:success]).to be_present
      end
    end

    context "update fail" do
      it "update fail" do
        expect {
          put :update, params: {id: pet.id, pet: invalid_pet}
        }.to change(Pet, :count).by(0)
        expect(response).to have_http_status(200)
        expect(flash[:success]).not_to be_present
      end
    end
  end

  describe "#destroy" do
    context "destroy successfully" do
      it "destroy successfully" do
        expect {
          delete :destroy, params: { id: pet.id }
        }.to change(Pet, :count).by(-1)
        expect(response).to have_http_status(200)
      end
    end
    context "destroy fail" do
      it "destroy fail" do
        expect {
          delete :destroy, params: { id: "" }
        }.to change(Pet, :count).by(0)
        expect(response).to have_http_status(302)
      end
    end
  end
end
