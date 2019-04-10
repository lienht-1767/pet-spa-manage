class Admin::CommentsController < Admin::BaseController
  def index
    @comments = Comment.page(params[:page]).includes(:user, :post).per Settings.per_page
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    if @comment.destroy
      flash[:success] = t ".deleted"
      redirect_to admin_comments_url
    else
      flash[:error] = t ".delete_fail"
      redirect_to admin_comments_url
    end
  end
end
