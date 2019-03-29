class StaticPagesController < ApplicationController
  def home
    @post = Post.most_likes
    @services = Service.all_services.limit Settings.limit_home
    @posts = Post.all_posts.limit Settings.limit_home
  end
end
