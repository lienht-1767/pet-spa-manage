class CommentsController < ApplicationController
	before_action :load_post
  before_action :load_comment, only: [:destroy, :edit, :update, :comment_owner]
  before_action :comment_owner, only: [:destroy, :edit, :update]

  def new
    @comment = @post.comments.build
  end

  def create
    @comments = Comment.lastest_by_post(@post)
    @comment = @post.comments.new(params[:comment].permit(:content))
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.js
        format.html {redirect_to post_path(@post)}
        format.json {render :show}
      else
        format.html {render "posts/show" }
        format.json {render json: @comment.errors }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @comments = Comment.lastest_by_post(@post)
    respond_to do |format|
    if @comment.update(params[:comment].permit(:content))
      format.js
    else
      format.js
    end
    end
  end

  def destroy
    @comments = Comment.lastest_by_post(@post)
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to post_path(@post)}
      format.js
    end
  end

  private
  def load_post
    @post = Post.find(params[:post_id])
  end

  def load_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_owner
    unless current_user.id == @comment.user_id
      flash[:notice] = t ".notice"
      redirect_to @post
    end

  end
end
