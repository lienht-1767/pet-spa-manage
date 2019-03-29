class PostsController < ApplicationController
  before_action :load_post, only: %i(show)

  def index
    @posts = Post.page(params[:page]).per Settings.quantity_per_page
  end

  def show
    @other_posts = Post.other_posts(@post).limit Settings.limit_home
  end

  private
  def load_post
    @post = Post.find_by id: params[:id]
    return if @post
    flash[:error] = t(".post_not_found")
    redirect_to root_path
  end
end
