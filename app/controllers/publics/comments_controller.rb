class Publics::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    @post = Post.find(params[:id])
    render :comment
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    @post = Post.find(params[:id])
    render :comment
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
