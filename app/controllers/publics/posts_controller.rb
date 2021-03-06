class Publics::PostsController < ApplicationController
  before_action :authenticate_customer!,except: [:index, :show]
  before_action :ensure_customer, only: [:edit]

  def new
    @post = Post.new
    @genre = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post.score = Language.get_data(post_params[:detail])

    if @post.save
      redirect_to post_path(@post), notice: "投稿が登録されました"
    else
      @genre = Genre.all
      render :new
    end
  end

  def index
    posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts.where(status: true) : Post.where(status: true)
    @posts = posts.page(params[:page]).per(6)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @tags = @post.tags
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, notice: "投稿が削除されました"
    else
      @comment = Comment.new
      @tags = @posts.tags
      render :show
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿内容が変更されました"
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :address, :category, :recommend, :genre_id, :clean, :detail, :latitude, :longitude, :status, tag_ids: [])
  end

  def ensure_customer
    @post = Post.find(params[:id])
    if @post.customer != current_customer
      redirect_to posts_path, notice: "このページには遷移できません"
    end
  end

end
