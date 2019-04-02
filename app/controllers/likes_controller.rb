class LikesController < ApplicationController
  before_action :load_post
  before_action :load_like, only: :destroy

  def create
    if liked?
      flash[:error] = t ".cannot_like"
      redirect_to post_path @post
    else
      @post.likes.create user_id: current_user.id
      respond_to do |format|
        format.html {redirect_to post_path @post}
        format.js
      end
    end
  end

  def destroy
    if !(liked?)
      flash[:error] = t ".cannot_dislike"
      redirect_to post_path @post
    else
      @like.destroy
      respond_to do |format|
        format.html {redirect_to post_path @post}
        format.js
      end
    end
  end

  private
  def load_post
    @post = Post.find_by id: params[:post_id]
  end

  def load_like
    @like = @post.likes.find_by id: params[:id]
  end

  def liked?
    Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
  end
end
