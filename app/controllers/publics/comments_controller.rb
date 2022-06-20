class Publics::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    render :comment
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    @post = Post.find(params[:post_id])
    render :comment, notice: "コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
