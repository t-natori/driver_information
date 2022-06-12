class Publics::PostsController < ApplicationController
  before_action :authenticate_customer!,except:  [:show]

  def new
    @post = Post.new
    @genre = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to post_path(@post.id), notice: "投稿が登録されました"
    else
      @post = Post.new
      @genre = Genre.all
      render :new
    end
  end

  def index
    @post = Post.find(params[:id])
    
  end

  def show
  end

  def destroy

  end

  def edit
  end

  def update

  end

  private

  def post_params
    params.require(:post).permit(:name, :address, :type, :recommend, :genre, :clean, :parking, :detail, :status)
  end

end
