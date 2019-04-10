require "rails_helper"

RSpec.describe Admin::CommentsController, type: :controller do
  before :each do
    user = FactoryBot.create :user
    session[:user_id] = user.id
  end

  context "#index" do
    it "responds successfully" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  let!(:comment) {FactoryBot.create :comment}
  context "#destroy" do
    it "delete the comment" do
      expect {delete :destroy, params: { id: comment.id }}.to change(Comment, :count).by(-1)
      expect(flash[:success]).to be_present
    end
    it  "delete fail" do
      expect {delete :destroy, params: { id: ""}}
      expect(flash[:error]).to be_present
    end
  end
end
