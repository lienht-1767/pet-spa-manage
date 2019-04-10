require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user)
    session[:user_id] = @user.id
    @post = FactoryBot.create(:post)
  end

  let(:valid_comment) {
    {
      post_id: 1,
      user_id: 1,
      content: FFaker::Lorem.phrase,
    }
  }
  let(:invalid_comment) {
    {
      post_id: "",
      user_id: "",
      content: "",
    }
  }

  describe "#new" do
    before :each do
      get :new, xhr: true, params: {post_id: @post}
    end
    it "responds successfully" do
      expect(response).to have_http_status(204)
    end
    it "assigns a new comment" do
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe "#create" do
    context "create successfully" do
      before :each do
        post :create, xhr: true, params: {comment: valid_comment, post_id: @post}
      end
      it "creates a comment" do
        expect(Comment.count).to eq(1)
      end
    end
    context "create fail" do
      before :each do
        post :create, xhr: true, params: {comment: invalid_comment, post_id: @post}
      end
      it "creates a comment" do
        expect(Comment.count).to eq(0)
      end
    end
  end

  let!(:comment) { FactoryBot.create :comment }
  describe "#update" do
    context "#update" do
      before :each do
        put :update, xhr: true, params: {id: comment.id, comment: valid_comment, post_id: @post}
      end
      it "update successfully" do
        expect(response).to have_http_status(200)
        expect(flash[:success]).to be_present
      end
    end
    context "update fail" do
      before :each do
        put :update, xhr: true, params: {id: comment.id,
         comment: invalid_comment, post_id: @post}
      end
      it "update fail" do
        expect(response).to have_http_status(302)
        expect(flash[:success]).not_to be_present
      end
    end
  end

  describe "#destroy" do
    context "destroy successfully" do
      before :each do
        delete :destroy, xhr: true, params: {id: comment.id, post_id: @post}
      end
      it "destroy the comment" do
        expect(Comment.count).to eq(-1)
        expect(response).to have_http_status(200)
      end
    end
    context "destroy fail" do
      before :each do
        delete :destroy, xhr: true, params: {id: "", post_id: @post}
      end
      it "destroy the comment" do
        expect(Comment.count).to eq(0)
        expect(response).to have_http_status(200)
      end
    end
  end
end
