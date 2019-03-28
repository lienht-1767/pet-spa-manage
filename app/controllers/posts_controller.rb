class PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per Settings.quantity_per_page
  end

  def show
    @post = Post.find_by id: params[:id]
    @other_posts = Post.other_posts(@post.id)
  end
end
