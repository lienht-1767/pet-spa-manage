class CommentsController < ApplicationController
  before_action :load_post
  before_action :load_comment, only: %i(destroy edit update comment_owner)
  before_action :comment_owner, only: %i(destroy edit update)

  def new
    @comment = @post.comments.build
  end

  def create
    @comments = Comment.lastest_by_post @post
    @comment = @post.comments.new comment_params
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.js
        format.html {redirect_to post_path @post}
      else
        format.html {render "posts/show" }
      end
    end
  end

  def edit
    respond_to :js
  end

  def update
    @comments = Comment.lastest_by_post @post
    @comment.update comment_params
    respond_to :js
  end

  def destroy
    @comments = Comment.lastest_by_post @post
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to post_path @post}
      format.js
    end
  end

  private
  def load_post
    @post = Post.find_by id: params[:post_id]
    return if @post
    flash[:notice] = t ".post_not_found"
    redirect_to @post
  end

  def load_comment
    @comment = @post.comments.find_by id: params[:id]
    return if @comment
    flash[:notice] = t ".comment_not_found"
    redirect_to @post
  end

  def comment_owner
    return if current_user.id == @comment.user_id
    flash[:notice] = t ".notice"
    redirect_to @post
  end

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end
end
