class MapsController < ApplicationController
  def top
  end

  def index
    @post = Post.new
  end
end
