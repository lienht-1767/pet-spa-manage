class StaticPagesController < ApplicationController
  def home
    @post = Post.most_likes
    @services = Service.all.limit(3)
    @posts = Post.all.limit(3)
  end
end
