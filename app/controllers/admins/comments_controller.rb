class Admins::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    @post = Post.find(params[:post_id])
    render :comment, notice: "コメントを削除しました"
  end
end
