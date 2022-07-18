class Publics::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @posts = Post.looks(params[:search], params[:word]).page(params[:page]).per(6)
  end
end
