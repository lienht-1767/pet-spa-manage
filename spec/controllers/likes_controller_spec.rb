require "rails_helper"

RSpec.describe LikesController, type: :controller do
  before :each do
    @user = FactoryBot.create :user
    session[:user_id] = @user
    @post = FactoryBot.create :post
  end
  let(:valid_attributes) {
    {
      post_id: @post,
      user_id: @user,
      status: 1
    }
  }

  let!(:like) { FactoryBot.create :like }

  describe "#create" do
    context "create successfully" do
      before :each do
        post :create, xhr: true, params: {post_id: @post}
      end
      it "creates a like" do
        expect(Like.count).to eq(1)
      end
    end
  end

  describe "#destroy" do
    context "destroy successfully" do
      before :each do
        @like = FactoryBot.create :like
        delete :destroy, xhr: true, params: {id: @like, post_id: @post}
      end
      it "destroy the like" do
        expect(Like.count).to eq(-1)
        expect(response).to have_http_status(200)
      end
    end
  end
end
