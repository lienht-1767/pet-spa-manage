class StaticPagesController < ApplicationController
  def home
    @post = Post.most_likes
    @services = Service.all
    @posts = Post.all
  end
end
