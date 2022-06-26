class Publics::FavoritesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer

    @posts = @customer.posts.where(status: true)
    @favorites = Favorite.where(customer_id: current_customer.id).pluck(:post_id)
    @favorites_list = Post.where(id: @favorites).where(status: true)
  end

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.new(post_id: @post.id)
    @favorite.save
    # redirect_back fallback_location: root_path
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_customer.favorites.find_by(post_id: @post.id)
    @favorite.destroy
    # redirect_back fallback_location: root_path
  end

end
