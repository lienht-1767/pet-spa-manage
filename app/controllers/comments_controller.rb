class CommentsController < ApplicationController
  before_action :load_post
  before_action :load_comment, only: %i(destroy edit update comment_owner)
  before_action :comment_owner, only: %i(destroy edit update)

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
        format.html {redirect_to post_path(@post), notice: 'Comment was successfully created.'}
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
    @post = Post.find_by id: params[:post_id]
    return if @post
    flash[:notice] = "post not found"
    redirect_to @post
  end

  def load_comment
    @comment = @post.comments.find_by id: params[:id]
    return if @comment
    flash[:notice] = @post.comments.find_by id: params[:id]
    redirect_to @post
  end

  def comment_owner
    return if current_user.id == @comment.user_id
    flash[:notice] = "not user"
    redirect_to @post
  end
end
