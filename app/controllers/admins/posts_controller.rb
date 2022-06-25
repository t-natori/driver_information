class Admins::PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admins_posts_path, notice: "投稿を削除しました"
    else
      render :show
    end
  end
end
