class MapsController < ApplicationController
  def top
  end

  def index
    @posts = Post.all
  end
end
